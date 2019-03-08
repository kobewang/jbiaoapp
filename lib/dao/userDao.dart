
import 'package:jbiaoapp/dao/dataResult.dart';
import 'package:jbiaoapp/net/api.dart';
/// 用户Dao
///
/// auth:wyj date:20190308
class UserDao {
  
  //微信Oauth登录
  static wxOauth(String  code) async {
    var params ={
        "Code": code,
        "Plat": "jbiao"
      };
    var res =
        await HttpManager.post(HttpManager.API_USER_WX_LOGIN, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      print(data);
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }
}