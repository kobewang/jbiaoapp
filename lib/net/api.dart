import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:jbiaoapp/net/code.dart';
import 'package:jbiaoapp/net/resultdata.dart';

///网络处理
///
///
class HttpManager {
  static final String API_HOST = 'https://api.yms.cn';

  ///分类详细
  static final String API_TYPE_DETAIL = API_HOST + "/tm/type/detail";
  static final String API_GROUP_DETAIL = API_HOST + "/tm/group/detail";
  static final String API_GROUP_LIST = API_HOST + "/tm/group/list";
  static final String API_GOODS_LIST = API_HOST + "/tm/goods/list";
  static final String API_GOODS_SEARCH = API_HOST + "/tm/goods/search";
  //注册提交上传
  static final String API_TM_REG = API_HOST + '/xcxpic/uploadtmreg';
  //我的列表
  static final String API_TM_MYLIST = API_HOST + '/tm/my/list';
  static final String API_TM_MY_DETAIL = API_HOST + '/tm/my/detail';
  //登录注册
  static final String API_USER_WX_LOGIN = API_HOST + '/user/wx/login';
  //获取验证码
  static final String API_USER_GET_VCODE = API_HOST + '/user/getmcode';
  //绑定手机
  static final String API_USER_BIND_MOBILE = API_HOST + '/user/mobilebind';
  //获取用户信息
  static final String API_USER_GET_INFO = API_HOST + '/user/info';

  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null
  };

  static post(url, params, Map<String, String> header, Options option) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return ResultData(null, false, Code.NETWORK_ERROR);
    }
    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    //授权码
    if (optionParams["authorizationCode"] == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        optionParams["authorizationCode"] = authorizationCode;
      }
    }
    //header["Authorization"] =optionParams["authorizationCode"];
    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }
    //超时
    option.headers = headers;
    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.post(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null)
        errorResponse = response;
      else
        errorResponse = new Response(statusCode: 666);
      if (e.type == DioErrorType.CONNECT_TIMEOUT)
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      return new ResultData(null, false, errorResponse.statusCode);
    }
    return ResultData(response.data, true, Code.SUCCESS,
        headers: response.headers);
  }

  //从缓存读取token
  static getAuthorization() async {
    return null;
  }
}
