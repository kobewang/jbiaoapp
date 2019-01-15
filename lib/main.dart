import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/pages/home.dart';
import 'package:jbiaoapp/pages/tmlist.dart';
import 'package:jbiaoapp/pages/detail.dart';
import 'package:jbiaoapp/pages/message.dart';
import 'package:jbiaoapp/pages/news.dart';
import 'package:jbiaoapp/pages/webview.dart';

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
      home: new MyApp(),
      //home: new MessagePage(),
      //home: new DetailPage(),
      //home: new NewsPage(),
      //home: new WebView(url: 'https://www.22.cn')
    ),
  );
}

class MyApp extends StatefulWidget {   
  @override
  createState() => MyAppState();  
}
class MyAppState extends State<MyApp> {
  var bottomTabs = [
    new BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    new BottomNavigationBarItem(
      //icon: Icon(CupertinoIcons.group),
      icon: Icon(CupertinoIcons.collections),
      title: Text('商标')
    ),
    new BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('资讯')
    ),
    new BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('我的')
    ),
  ];
  final List tabBodies = [
    new HomePage(),
    new TmListPage(),
    new NewsPage(),
    //new Home(),
    new HomePage()
  ];
  var currentIndex = 0;
  var currentPage;
  @override
  void initState() {      
      currentPage = tabBodies[currentIndex];
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: currentPage,
    );
  }
}