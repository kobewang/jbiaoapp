import 'package:jbiaoapp/config/constants.dart';

/**
 * Uitl辅助类
 */
class Util {
    /// 0
  /// -1
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
 * 字符串截取
 */
  static String subStr(String str,int length,String hide){
    if(str.length<length)
      return str;
     return str.substring(0,length-1)+hide;
  }

}