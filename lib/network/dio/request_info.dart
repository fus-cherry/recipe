import 'package:dio/dio.dart';
import 'package:notepad/network/dio/dio.dart';
import 'package:notepad/utils/result.dart';
import 'package:notepad/utils/toast.dart';

class RequestInfo {
  /**
   * 处理请求信息,请求数据封装,打印请求数据等操作
   * 
   */

  // 创建私有的静态实例
  static final RequestInfo _instance = RequestInfo._();

  // 私有构造函数
  RequestInfo._();

  // 提供一个静态方法来获取实例
  static RequestInfo get instance => _instance;

  // 处理请求
  void handleRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    Toast.hide();
    Toast.show("请求前,请求url:${options.path}");
    Map requestData = {
      "url": options.uri.toString(),
      "method": options.method,
      "path": options.path,
      "data": options.data ?? "null",
      "queryParameters": options.queryParameters
    };
    _dealRequestInfo(requestData, DioHttp.REQUEST_TYPE_STR);
  }

  void handleResponse(Response response, ResponseInterceptorHandler handler) {
    Map responseData = {
      'url': response.requestOptions.uri,
      'method': response.requestOptions.method,
      'headers': response.headers,
      'data': response.data,
      'statusCode': response.statusCode,
      'statusMessage': response.statusMessage,
    };
    _dealRequestInfo(responseData, DioHttp.RESPONSE_TYPE_STR);
    Toast.hide();
  }

  void handleError(DioException error, ErrorInterceptorHandler handler) {
    String errorType = "其他错误";
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorType = "连接超时";
        break;
      case DioExceptionType.badCertificate:
        errorType = "证书错误";
        break;
      case DioExceptionType.badResponse:
        errorType = "响应错误";
        break;
      case DioExceptionType.unknown:
        errorType = "未知错误";
        break;
      case DioExceptionType.sendTimeout:
        errorType = "发送超时";
        break;
      case DioExceptionType.receiveTimeout:
        errorType = "接收超时";
        break;
      case DioExceptionType.cancel:
        errorType = "连接取消";
        break;
      case DioExceptionType.connectionError:
        errorType = "连接错误";
        break;
    }
    Map errorData = {
      'url': error.requestOptions.uri,
      'method': error.requestOptions.method,
      'headers': error.requestOptions.headers,
      'data': error.requestOptions.data,
      'statusCode': error.response?.statusCode,
      'statusMessage': error.response?.statusMessage,
      'errorType': errorType,
    };

    _dealRequestInfo(errorData, DioHttp.ERROR_TYPE_STR);
    Toast.hide();
    DioHttp.errorShowMsg =
        "${DioHttp.errorShowTitle} ${error.response?.statusCode ?? 'unknown'} $errorType \n ${error.response?.statusMessage ?? ''} ${error.message ?? ''} \n ${error.response?.data ?? ''}";
  }

  // 合并打印请求
  String _dealRequestInfo(Map structureString, String logType) {
    String logStr = "\n";
    logStr +=
        "========================= $logType START =========================\n";
    logStr += "- URL: ${structureString['url']} \n";
    logStr += "- METHOD: ${structureString['method']} \n";
    if (structureString['data'] != null) {
      logStr += "- ${logType}_BODY: \n";
      logStr +=
          "!!!!!----------*!*##~##~##~##*!*##~##~##~##*!*----------!!!!! \n";
      logStr += "${parseData(structureString['data'])} \n";
      logStr +=
          "!!!!!----------*!*##~##~##~##*!*##~##~##~##*!*----------!!!!! \n";
    }
    if (logType.contains(DioHttp.RESPONSE_TYPE_STR)) {
      logStr += "- STATUS_CODE: ${structureString['statusCode']} \n";
      logStr += "- STATUS_MSG: ${structureString['message']} \n";
    }
    if (logType == DioHttp.ERROR_TYPE_STR) {
      logStr += "- ERROR_TYPE: ${structureString['errorType']} \n";
      logStr += "- ERROR_MSG: ${structureString['errorMessage']} \n";
      logStr += "- ERROR_TYPE_INFO: ${structureString['errorTypeInfo']} \n";
    }
    logStr +=
        "========================= $logType E N D =========================\n";
    logWrapped(logStr);
    return logStr;
  }

  //统一结果提示处理
  // resultDialogConfig 可以有 title, content, closeable, showCancel, cancelText, confirmText, confirmCallback, cancelCallback, closeCallback ...

  Future showResponseDialog(Response? response, resultDialogConfig) async {
    if (response == null) return;

    resultDialogConfig = resultDialogConfig ?? {};
    String dialogType = resultDialogConfig["type"] ?? DioHttp.DIALOG_TYPE_TOAST;

    //其他处理方式
    if (dialogType == DioHttp.DIALOG_TYPE_OTHERS) return;

    bool isSuccess = response.data.success ?? false;
    String msg = response.data.msg ?? response.statusMessage;
    if (dialogType == DioHttp.DIALOG_TYPE_TOAST) {
      Toast.show(resultDialogConfig["msg"] ?? msg,
          type: isSuccess ? ToastType.SUCCESS : ToastType.ERROR);
      return;
    } else if (dialogType == DioHttp.DIALOG_TYPE_TOAST) {
      //处理轻提醒
      return;
    } else
      return;
  }

  //错误抓取处理
  void catchError(e) {
    String errorMsg =
        "$e${DioHttp.CUSTOM_ERROR_CODE}".split(DioHttp.CUSTOM_ERROR_CODE)[0];
    //错误长度处理
    var errorLegth = errorMsg.length;
    String errorShowMsg =
        errorLegth > 300 ? errorMsg.substring(0, 300) : errorMsg;

    if (e is DioException) {
      if (CancelToken.isCancel(e)) {
        Toast.show("cancel Request sucessful");
        return;
      }
      Toast.show(errorShowMsg, type: ToastType.WARNING);
    }
    Toast.show(errorShowMsg, type: ToastType.ERROR);
  }

  /// 分段 log，可以写到 log 中。
  void logWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
