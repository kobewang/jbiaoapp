import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/util/util.dart';

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

  static showAlert(
    BuildContext context,
    String msg, {
    Widget child,
    double childHeight,
    String okLabel: "确定",
    VoidCallback ok,
    String cancelLabel,
    VoidCallback cancel,
    bool barrierDismissible: true,
  }) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (_) {
          if (child == null && msg != null && msg != "") {
            child = Text(
              msg,
              style: TextStyle(
                fontSize: Util.getPXSize(context, 30.0),
                color: Color.fromRGBO(105, 105, 105, 1.0),
              ),
              maxLines: 20,
            );
            childHeight =
                40.0 * (msg.length / 15 + (msg.length % 15 == 0 ? 0 : 1));
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(30),
              height: 30 +
                  childHeight +
                  30 +
                  Util.getPXSize(context, 90) +
                  10 +
                  (cancelLabel != null || cancel != null
                      ? Util.getPXSize(context, 90) + 10
                      : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: child,
                  ),
                  //确定按钮
                  okLabel != null && okLabel != ""
                      ? Container(
                          height: Util.getPXSize(context, 90.0),
                          width: Util.getPXSize(context, 360.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (ok != null) {
                                  ok();
                                }
                              },
                              child: Text(
                                okLabel,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Util.getPXSize(context, 32.0),
                                ),
                              )),
                        )
                      : Container(),
                  //取消按钮
                  cancelLabel != null || cancel != null
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          height: Util.getPXSize(context, 90.0),
                          width: Util.getPXSize(context, 400.0),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (cancel != null) {
                                  cancel();
                                }
                              },
                              child: Text(
                                cancelLabel ?? "取消",
                                style: TextStyle(
                                  fontSize: Util.getPXSize(context, 28.0),
                                  color: Color.fromRGBO(137, 137, 137, 1.0),
                                ),
                              )),
                        )
                      : Container()
                ],
              ),
            ),
          );
        });
  }

}