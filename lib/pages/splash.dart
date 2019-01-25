import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/config/api.dart';
import 'package:jbiaoapp/config/constants.dart';
import 'package:jbiaoapp/pages/home.dart';
import 'package:jbiaoapp/pages/main.dart';
import 'package:jbiaoapp/util/NetUtils.dart';
import 'package:jbiaoapp/widgets/skip_down_time.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:jbiaoapp/pages/webview.dart';
import 'package:jbiaoapp/pages/detail.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
/**
 * 欢迎页
 */
class SplashPage extends StatefulWidget {
  @override
  createState ()=> SplashPageState();
}
class SplashPageState extends State<SplashPage> implements OnSkipClickListener {
   var welcomeImageUrl = 'https://www.jbiao.cn/images/news/appwelcome.jpg';
  JPush jPush = new JPush();
  String registerId;
  String myMsg;

  _startupJpush() {
    jPush.setup(appKey: Constants.WX_APPID, channel: "developer-default",debug: true);
  }

  _getRegisterID() async {
    registerId = await jPush.getRegistrationID();
    print('*********registerid=' + registerId);
    return registerId;
  }

  _setPushTag() {
    List<String> tags = List<String>();
    tags.add("jason");
    jPush.setTags(tags);
  }

  _addEventHandler() {
// Future<dynamic>event;
    jPush.addEventHandler(onReceiveNotification: (Map<String, dynamic> event) {
      print('*********addOnreceive>>>>>>$event');//进程运行时候可以接受          
      var title = event['alert'];
      var extra = json.decode(event['extras']['cn.jpush.android.EXTRA']);      
      notifyRoute(extra['type'],title,extra['id']);        
      print('*********msg:$event');
    }, onOpenNotification: (Map<String, dynamic> event) {
      print('*********addOpenNoti>>>>>$event'); //进程关闭的时候可以接受
      var title = event['alert'];
      var extra = json.decode(event['extras']['cn.jpush.android.EXTRA']);
      notifyRoute(extra['type'],title,extra['id']);
    }, onReceiveMessage: (Map<String, dynamic> event) {
      print('*********addReceiveMsg>>>>>$event'); //进程运行时候可以接受      
      print(event.toString());
      var jsStr = json.decode(event.toString());
    });
  }

  //推送跳转
  void notifyRoute(String type,String title,String id) {    
    if(type!=null) {
      switch(type){
        case 'news': 
          Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new WebView(title: title, url:id )));
        break;
        case 'tmdetail':
          Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new DetailPage(tmId: int.parse(id))));
        break;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fluwx.register(appId:"wxd930ea5d5a258f4f");
    _startupJpush();
    _setPushTag();
    _addEventHandler();
    print('******_getRegisterID');
    _getRegisterID();
    _getWelcomeImage();
    _delayedGoHomePage();
  }
  _delayedGoHomePage() {
    Future.delayed(new Duration(seconds: 5), () {
      _goHomePage();
    });
  }
    _getWelcomeImage() async {
     String url = Api.INDEXAD;
      NetUtils.post(url, null).then((data){
      setState(() {
          var bannerList = json.decode(data)['Data']['List'];
          for(var i=0;i<bannerList.length;i++){
            if(bannerList[i]['Location'] == 2)
              welcomeImageUrl = bannerList[i]['AdImg'];
          }
        });
      });
    }
  
  
  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          color: Colors.white,
          child: new  Image.network(welcomeImageUrl,fit:BoxFit.cover),
          constraints: new BoxConstraints.expand(),
        ),
        new Container(
          child: Align(
            alignment: Alignment.topRight,
            child: new Container(
              padding: EdgeInsets.only(top:30.0,right: 20.0),
              child: new SkipDownTimeProgress(
                Colors.blue,
                22.0,
                new Duration(seconds: 5),
                new Size(25.0,25.0),
                skipText: "跳过",
                clickListener:this
              ),
            ),
          ),
        )
        
      ],
    );
  }

  
  @override
  void onSkipClick() {
    _goHomePage();
  }
    _goHomePage() {
    //Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new MainPage()));    
    Navigator.of(context).pushNamed('/main');
  }
}