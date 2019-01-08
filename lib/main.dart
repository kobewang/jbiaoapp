import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/pages/home.dart';
import 'package:jbiaoapp/pages/tmlist.dart';

//void main() => runApp(MyApp());

void main() {
  runApp(
     new MaterialApp(
      title: 'app',
      theme: new ThemeData(
        //primaryColor:Colors.lightBlueAccent,
      ),
      home: new MyApp(),
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
      title: Text('列表')
    ),
    new BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('发现')
    ),
    new BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('我的')
    ),
  ];
  final List tabBodies = [
    new TmList(),
    new Home(),
    new Home(),
    new Home()
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