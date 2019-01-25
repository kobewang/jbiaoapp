import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jbiaoapp/config/api.dart';
import 'package:jbiaoapp/util/NetUtils.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:jbiaoapp/widgets/baroption.dart';
import 'package:jbiaoapp/config/constants.dart';
import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';

/**
 * 关于我们
 */
class AboutPage extends StatefulWidget {
  @override
  createState ()=> AboutPageState();
}
class AboutPageState extends State<AboutPage> {
  String versionStr="";
  String versionName="";
  OptionControl control = new OptionControl();
  

  @override
  void initState() {
      getAPIERSION();
      // TODO: implement initState
      super.initState();
      control.url = Constants.DOMAIN;
  }
 //请求API
  getAPIERSION() async {
    if(Platform.isIOS) {
      return;
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;  
    Version currentNum = Version.parse(versionName);   
    String url = Api.VERSION;    
    var postParam = {};
    NetUtils.post(url,postParam).then((data) {  
      String versionCode = json.decode(data)['Data']['VersionCode'].toString();        
      String versionName = json.decode(data)['Data']['VersionName'].toString();    
      String releaseStr = json.decode(data)['Data']['ReleaseStr'].toString();        
      Version versionNameNum = Version.parse(versionName);
      int result = versionNameNum.compareTo(currentNum);
      if (result > 0) {
        setState(() {                                 
          versionStr="有新版本，去更新吧";
        });
        Util.showUpdateDialog(context, versionName + ": " + releaseStr);
      } else {
        Fluttertoast.instance.showToast(msg: '当前已是最新版');
        setState(() {                                 
          versionStr="已是最新版";
        });
      }    
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('关于我们'),
        centerTitle: true,
        actions: <Widget>[
          BarOptionWidget(control)
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: 
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  child: new Image.network('https://www.jbiao.cn/images/ic_launcher.png'),
                  width: 150.0,
                  height: 150.0,
                  margin: EdgeInsets.only(bottom: 5.0),
                ),
                new Text('集标网-商标买卖交流社区')
              ],
            )
          ),
          new Divider(height: 1.0),
          new ListTile(title: new Text('电话：400-0573-220')),
          new Divider(height: 1.0),
          new ListTile(title: new Text('公司：浙江集标知识产权服务有限公司')),
          new Divider(height: 1.0),
          new ListTile(title: new Text('版本：${versionName} ${versionStr}')),
        ],
      ),
    );
  }
}