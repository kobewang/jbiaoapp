import 'package:fluttertoast/fluttertoast.dart';
/// Dialog弹窗toast
///
/// auth:wyj date:20190222
class  MyDialog {
  static showToast(String msg,{String gravity:'center'}) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: gravity=="center"?
      ToastGravity.CENTER
      :(gravity=="bottom")?ToastGravity.BOTTOM:ToastGravity.TOP
    );
  }
}