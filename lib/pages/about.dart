import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/config/api.dart';
import 'package:jbiaoapp/util/NetUtils.dart';
import 'package:jbiaoapp/util/util.dart';
/**
 * 关于我们
 */
class AboutPage extends StatefulWidget {
  @override
  createState ()=> AboutPageState();
}
class AboutPageState extends State<AboutPage> {
  String versionStr="";

  @override
  void initState() {
      getAPIERSION();
      // TODO: implement initState
      super.initState();
  }
 //请求API
  getAPIERSION() {
    String url = Api.VERSION;    
    var postParam = {};
    NetUtils.post(url,postParam).then((data) {      
      setState(() {                        
        String curVersion = json.decode(data)['Data'].toString();        
        versionStr=Util.getUpdateStatus(curVersion)==0? "已是最新版":"有新版本，去更新吧";
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('关于我们'),
        centerTitle: true,
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
          new ListTile(title: new Text('版本：0.0.1 ${versionStr}')),
        ],
      ),
    );
  }
}