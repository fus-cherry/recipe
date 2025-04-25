import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:notepad/network/dio/request_info.dart';
import 'package:notepad/utils/result.dart';

class DioHttp {
  //定义请求类型 : 一共有 GET , POST , PUT , DELETE , PATCH
  static const String GET = "GET";
  static const String POST = "POST";
  static const String PUT = "PUT";
  static const String DELETE = "DELETE";
  static const String PATCH = "PATCH";

  //自定义请求错误代码 , 请求类型 , 响应类型 , 错误类型 , 请求提示 等字符串
  //TODO 添加WebSocket连接断开错误 , 酌情添加

  static const String CUSTOM_ERROR_CODE = "CUSTOM_ERROR_CODE";
  static const String REQUEST_TYPE_STR = "REQUEST_TYPE_STR";
  static const String RESPONSE_TYPE_STR = "RESPONSE_TYPE_STR";
  static const String ERROR_TYPE_STR = "ERROR_TYPE_STR";
  static const String DELETE_LOAD_MSG = "请求中";

  //网络请求时间定义
  static const CONNECT_TIMEOUT = 50000; //连接超时
  static const RECEIVE_TIMEOUT = 50000; //接受超时
  static const SEND_TIMEOUT = 50000; //发送超时

  //请求结果类型处理 , 注重交互方便,用于分类提醒方式 , 根据提醒方式的侵入性进行分类
  static const String DIALOG_TYPE_TOAST = "DIALOG_TYPE_TOAST"; //处理结果  , 轻度提醒
  static const String DIALOG_TYPE_ALERT = "DIALOG_TYPE_ALERT"; //处理结构 , 重度提醒
  static const String DIALOG_TYPE_OTHERS = "DIALOG_TYPE_OTHERS"; //处理结果 , 其他
  static const String DIALOG_TYPE_CUSTOM = "DIALOG_TYPE_CUSTOM"; //自定义

  // 请求中的默认提示文字 , 错误提示文字
  static String loadMsg = DELETE_LOAD_MSG; //请求提示

  static String errorShowTitle = "error"; //错误提示

  static String errorShowMsg = ""; // 错误提示文本

  static CancelToken cancelToken = CancelToken(); //取消请求token , 默认全部取消

  static CancelToken whiteListCancelToken =
      CancelToken(); // 白名单列表 , 此列表中的token 不会被取消

  final Map<String, CancelToken> _pendingRequest = {};

  static Dio dio = Dio();

  final RequestInfo requestInfo = RequestInfo.instance;

  String _getBaseUrl() => getBaseUrl();

  DioHttp._internal() {
    //全局单例,第一次使用的时候进行初始化

    if (dio.options.baseUrl.isEmpty) {
      dio = Dio(BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: const Duration(milliseconds: CONNECT_TIMEOUT),
        receiveTimeout: const Duration(milliseconds: RECEIVE_TIMEOUT),
        sendTimeout: const Duration(milliseconds: SEND_TIMEOUT),
        extra: {'cancelDuplicateRequest': true},
      ));
      _init();
    }
  }

  //获取单例本身
  static final DioHttp _instance = DioHttp._internal();

  static DioHttp get instance => _instance;

  /**
   *  通过getInsance 进行调用,在多服务器情况下可以便捷切换baseUrl
   */
  static DioHttp getInstance({String? baseUrl, String? msg}) {
    final tragetBaseUrl = baseUrl ?? _instance._getBaseUrl();
    loadMsg = msg ?? DELETE_LOAD_MSG;
    if (dio.options.baseUrl != tragetBaseUrl) {
      dio.options.baseUrl = tragetBaseUrl;
    }
    return _instance;
  }

  //添加拦截器 , 进行初始化化操作
  void _init() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          kDebugMode ? print("请求前,请求url:${options.path}") : null;

          //判断请求是否需要避免重复请求,并且判断是都已经存在请求
          if (options.extra['cancelDuplicateRequest'] =
              true && options.cancelToken == null) {
            final tokenKey = [
              options.method,
              options.baseUrl,
              jsonEncode(options.data ?? []),
              jsonEncode(options.queryParameters)
            ].join("&");
            options.cancelToken = CancelToken();
            options.extra["tokenKey"] = tokenKey;
            _pendingRequest[tokenKey] = options.cancelToken!;
          }
          requestInfo.handleRequest(options, handler);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          kDebugMode ? print("响应之前") : null;
          RequestOptions options = response.requestOptions;
          if (options.cancelToken == null &&
              options.extra['cancelDuplicateRequest'] == true) {
            _removePendingRequest(options.extra['tokenKey'] as String);
          }

          //响应数据初步处理
          String code = (response.data["code"]).toString();
          String msg = response.data["message"] ?? response.statusMessage;
          bool isSuccess = options.contentType != null ||
              options.contentType!.contains("text") ||
              code == 200;

          //修改返回来的数据为标准数据结构
          response.data = Result(
              response.data, isSuccess, response.statusCode!, msg,
              handers: options.headers);
          requestInfo.handleResponse(response, handler);
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          kDebugMode ? print("请求出错:${error.message}") : null;
          //_handlerError(error);

          //不可抗错误清空请求表
          if (!CancelToken.isCancel(error) &&
              dio.options.extra['cancelDuplicateRequest'] == true) {
            _pendingRequest.clear();
          }

          //发生错误的时候也会返回一个Response,通过这个Response 获取对应的状态码等
          if (error.response != null && error.response?.data != null) {
            error.response?.data = Result(
                error.response?.data!,
                false,
                error.response!.statusCode!,
                error.response?.statusMessage ?? errorShowMsg,
                handers: error.response?.headers);
          } else
            throw Exception(errorShowMsg);
          return handler.next(error);
        },
      ),
    );
  }

  void _addPendingRequest(String key, CancelToken cancelToken) {
    _pendingRequest[key] = cancelToken;
  }

  void _removePendingRequest(String key) {
    _pendingRequest.remove(key);
  }

  /**
   *  Diohttp暴漏给外部方法,用于获取options,并且修改请求头等操作
   */

  //获取当前的baseUrl,在调用的时候存在初始化之前调用,需要做出处理
  static String getBaseUrl() {
    return dio.options.baseUrl;
  }

  static DioHttp setBaseUrl(String url) {
    dio.options.baseUrl = url;
    return _instance;
  }

  static Map getHeaders() {
    return dio.options.headers;
  }

  static DioHttp setHeaders(String Key, String value) {
    dio.options.headers[Key] = value;
    return _instance;
  }

  static DioHttp deleteHeaders(String key) {
    dio.options.headers.remove(key);
    return _instance;
  }

  static DioHttp clearHeaders() {
    dio.options.headers.clear();
    return _instance;
  }
  //
}
