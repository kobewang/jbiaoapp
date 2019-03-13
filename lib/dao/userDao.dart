import 'package:jbiaoapp/config/constants.dart';
import 'package:jbiaoapp/dao/dataResult.dart';
import 'package:jbiaoapp/local/localStorage.dart';
import 'package:jbiaoapp/model/userInfo.dart';
import 'package:jbiaoapp/net/api.dart';

/// 用户Dao
///
/// auth:wyj date:20190308
class UserDao {
  static isLogin() async {
    var token = await LocalStorage.get(Constants.APP_TOKEN);
    print('token:$token');
    if (token != null && token.isNotEmpty)
      return true;
    else
      return false;
  }

  //微信Oauth登录
  static wxOauth(String code) async {
    var params = {"Code": code, "Plat": "jbiao"};
    var res = await HttpManager.post(
        HttpManager.API_USER_WX_LOGIN, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      if (res.data['Code'] == 0) {
        var token = res.data['Data'].toString();
        await LocalStorage.save(Constants.APP_TOKEN, token);
      }
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  //获取验证码
  static getMobileCode(String mobile, String token) async {
    var params = {
      "userRequest": {
        "Token": token,
        "Plat": Constants.APP_PLAT,
        "TimeStamp": 0,
        "Sign": ""
      },
      "MobileNum": mobile
    };
    print(params);
    var res = await HttpManager.post(
        HttpManager.API_USER_GET_VCODE, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  //手机绑定验证
  static mobileBind(
      String mobile, String token, String vcode, int mCode) async {
    var params = {
      "userRequest": {
        "Token": token,
        "Plat": Constants.APP_PLAT,
        "TimeStamp": 0,
        "Sign": ""
      },
      "MobileNum": mobile,
      "Vcode": vcode,
      "Mcode": mCode
    };
    var res = await HttpManager.post(
        HttpManager.API_USER_BIND_MOBILE, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      if (res.data['Code'] == 0) {
         await LocalStorage.save(Constants.APP_TOKEN, token);
      }
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  // 获取用户信息
  static getUserInfo() async {
    var token =await LocalStorage.get(Constants.APP_TOKEN);
    var params = {
      "Token": token,
      "Plat": Constants.APP_PLAT,
      "TimeStamp": 0,
      "Sign": ""
    };
    print(params);
    var res = await HttpManager.post(
        HttpManager.API_USER_GET_INFO, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      print(data);
      UserInfo userInfo= UserInfo.fromJson(data['Data']);
      return new DataResult(userInfo, true);
    }
    return new DataResult(null, false);
  }
}
