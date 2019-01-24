import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/pages/home.dart';
import 'package:jbiaoapp/pages/main.dart';
import 'package:jbiaoapp/pages/splash.dart';
import 'package:jbiaoapp/pages/about.dart';
import 'package:jbiaoapp/pages/tmlist.dart';
import 'package:jbiaoapp/pages/detail.dart';
import 'package:jbiaoapp/pages/news.dart';
import 'package:jbiaoapp/pages/myinfo.dart';
import 'package:jbiaoapp/pages/webview.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

//void main() => runApp(MyApp());

void main() {
  runApp(
     new MaterialApp(
      title: 'app',
      theme: new ThemeData(
        backgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),
        scaffoldBackgroundColor:  new Color.fromRGBO(244, 245, 245, 1.0),
        //primaryColor:Colors.lightBlueAccent,
      ),
      home: new SplashPage(),
      routes: <String,WidgetBuilder>{
        '/home':(_) =>  new HomePage(),
        '/main':(_) =>  new MainPage(),
        '/tmlist':(_) =>  new TmListPage(),
        '/about':(_) =>  new AboutPage()
      },
      //home: new MessagePage(),
      //home: new DetailPage(),
      //home: new NewsPage(),
      //home: new WebView(url: 'https://www.22.cn')
    ),
  );
}