//请求结果处理

import 'package:dio/dio.dart';
import 'package:notepad/utils/extension.dart';

class Result {
  var data;
  bool success;
  int code;
  String msg;
  var handers;
  Result(
    this.data,
    this.success,
    this.code,
    this.msg, {
    this.handers,
  });
}

/// 数据处理解析
String parseData(data) {
  String responseStr = "";
  if (data is Map) {
    responseStr += data.mapToStructureString();
  } else if (data is FormData) {
    final formDataMap = Map()
      ..addEntries(data.fields)
      ..addEntries(data.files);
    responseStr += formDataMap.mapToStructureString();
  } else if (data is List) {
    responseStr += data.listToStructureString();
  } else {
    responseStr += data.toString();
  }
  return responseStr;
}
