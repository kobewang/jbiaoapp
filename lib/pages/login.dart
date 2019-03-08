import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import 'package:jbiaoapp/dao/userDao.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

/// 登录页面
///
/// auth:wyj date:20190308
class LoginPage extends StatefulWidget {
  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    fluwx.register(
        appId: "wxbdb66154033d3505", doOnAndroid: true, doOnIOS: true);
    super.initState();
  }

  //横线
  horizonLine() {
    return Container(
      height: Util.getPXSize(context, 1),
      width: Util.getPXSize(context, 200),
      color: Color.fromRGBO(217, 217, 217, 1.0),
    );
  }

  String code = "";
  String dataStr = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('登录'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.asset('images/login_bg_top.jpg'),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: Util.getPXSize(context, 100)),
                  child: Row(
                    children: <Widget>[
                      horizonLine(),
                      Expanded(
                        child: Center(
                          child: Text(
                            '微信登录:${code}  dataStr:${dataStr}',
                            style: TextStyle(
                              color: Color.fromRGBO(153, 153, 153, 1.0),
                              fontSize: Util.getPXSize(context, 26.0),
                            ),
                          ),
                        ),
                      ),
                      horizonLine()
                    ],
                  )),
            ),
            Center(
                child: Container(
                    margin: EdgeInsets.only(top: Util.getPXSize(context, 100)),
                    width: Util.getPXSize(context, 480),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            fluwx.WeChatScene scene =
                                fluwx.WeChatScene.TIMELINE;
                            fluwx
                                .share(WeChatShareTextModel(
                                    text: "text from fluwx",
                                    transaction: "transaction}",
                                    scene: scene))
                                .then((data) {
                              print(data);
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset('images/login_icon_wechat.png'),
                              Text('分享到微信',
                                  style: TextStyle(
                                    color: Color.fromRGBO(153, 153, 153, 1.0),
                                    fontSize: Util.getPXSize(context, 26.0),
                                    height: 1.5,
                                  ))
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              var auth = await fluwx.sendAuth(
                                  scope: "snsapi_userinfo",
                                  state: "wechat_sdk_demo_test");
                              print(auth);
                              setState(() {
                                code = 'code:${auth}';
                              });
                              await fluwx.responseFromAuth.listen((response) {
                                setState(() {
                                  code = 'response:' + response.code;
                                });
                                var res =  UserDao.wxOauth(response.code);
                              print(res.data);
                              setState(() {
                                dataStr = res.data['Code'].toString();
                              });
                              });
                              
                            },
                            child: Column(children: <Widget>[
                              Image.asset('images/login_icon_wechat.png'),
                              Text('微信一键登录',
                                  style: TextStyle(
                                    color: Color.fromRGBO(153, 153, 153, 1.0),
                                    fontSize: Util.getPXSize(context, 26.0),
                                    height: 1.5,
                                  ))
                            ])),
                        GestureDetector(
                          onTap: (){
                            var authcode = fluwx.sendAuth(
                                  scope: "snsapi_userinfo",
                                  state: "wechat_sdk_demo_test");
                                         setState(() {
                                  code = 'code:${authcode}';
                              });
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset('images/login_icon_wechat.png'),
                            ],
                          ),
                        )
                      ],
                    )))
          ],
        ));
  }
}
