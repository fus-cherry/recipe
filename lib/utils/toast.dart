import 'package:flutter_easyloading/flutter_easyloading.dart';

enum ToastType { SUCCESS, ERROR, INFO, WARNING, DEFAULT }

class Toast {
  Toast._();

  static loading(String msg) {
    EasyLoading.show(status: msg);
  }

  static show(String msg, {ToastType? type}) {
    switch (type) {
      case ToastType.SUCCESS:
        EasyLoading.showSuccess(msg);
        break;
      case ToastType.ERROR:
        EasyLoading.showError(msg);
        break;
      case ToastType.INFO:
        EasyLoading.showInfo(msg);
        break;
      case ToastType.WARNING:
        EasyLoading.showInfo(msg);
        break;
      default:
        EasyLoading.showInfo(msg);
        break;
    }
  }

  static hide() {
    EasyLoading.dismiss();
  }
}
