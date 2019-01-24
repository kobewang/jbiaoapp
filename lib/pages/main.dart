import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/pages/home.dart';
import 'package:jbiaoapp/pages/myinfo.dart';
import 'package:jbiaoapp/pages/news.dart';
import 'package:jbiaoapp/pages/tmlist.dart';
/**
 * Bottom导航主页
 */
class MainPage extends StatefulWidget {
  @override
  createState ()=> MainPageState();
}
class MainPageState extends State<MainPage> {
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
    new TmListPage(isLeading: false),
    new NewsPage(),
    //new Home(),
    new MyInfoPage()
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