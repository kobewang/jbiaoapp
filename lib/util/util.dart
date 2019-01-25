import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jbiaoapp/config/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * Uitl辅助类
 */
class Util {
   ///版本更新
  static Future<Null> showUpdateDialog(BuildContext context, String contentMsg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('版本更新'),
            content: new Text(contentMsg),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text('取消')),
              new FlatButton(
                  onPressed: () {
                    launch(Constants.APP_DOWNLOAD_URL);
                    Navigator.pop(context);
                  },
                  child: new Text('确认'),
              )
            ],
          );
        });
  }
  /// 0
  /// -1 判断APP更新状态
  /// 1
  static int getUpdateStatus(String version) {
    String locVersion = Constants.VERSION;
    int remote = int.tryParse(version.replaceAll('.', ''));
    int loc = int.tryParse(locVersion.replaceAll('.', ''));
    if (remote <= loc) {
      return 0;
    } else {
      return (remote - loc >= 2) ? -1 : 1;
    }
  }

/**
 * 系统复制
 */
  static void copy(String data) {
    Clipboard.setData(new ClipboardData(text: data));   
    Fluttertoast.instance.showToast(msg: '复制成功');
  }
/**
 * 在浏览器中打开
 */
static Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Fluttertoast.instance.showToast(msg:'浏览器打开失败:'+url);
  }
}
/**
 * 字符串截取
 */
  static String subStr(String str,int length,String hide){
    if(str.length<length)
      return str;
     return str.substring(0,length-1)+hide;
  }

}