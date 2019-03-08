import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/pages/RegTm.dart';
import 'package:jbiaoapp/pages/home.dart';
import 'package:jbiaoapp/pages/main.dart';
import 'package:jbiaoapp/pages/my/tm/list.dart';
import 'package:jbiaoapp/pages/splash.dart';
import 'package:jbiaoapp/pages/about.dart';
import 'package:jbiaoapp/pages/tmlist.dart';
import 'package:jbiaoapp/pages/types.dart';
import 'package:jbiaoapp/pages/login.dart';
import 'package:jbiaoapp/pages/detail.dart';
import 'package:jbiaoapp/pages/news.dart';
import 'package:jbiaoapp/pages/myinfo.dart';
import 'package:jbiaoapp/pages/webview.dart';

void main() {
  runApp(
     new MaterialApp(
      title: 'app',
      theme: new ThemeData(
        backgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),
        scaffoldBackgroundColor:  new Color.fromRGBO(244, 245, 245, 1.0),
      ),
      //home: new HomePage(),
      //home: new SplashPage(),
      //home: new MyTmListPage(),
      home: new LoginPage(),
      routes: <String,WidgetBuilder>{
        '/login':(_) =>  new LoginPage(),
        '/home':(_) =>  new HomePage(),
        '/regtm':(_) =>  new RegtmPage(),
        '/typelist':(_) =>  new TypesPage(),
        '/main':(_) =>  new MainPage(),
        '/tmlist':(_) =>  new TmListPage(),
        '/about':(_) =>  new AboutPage(),
        '/my/tmlist':(_) => new MyTmListPage()
      },      
    ),
  );
}