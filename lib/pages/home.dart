import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
class Home extends StatefulWidget {
  @override
  HomeState createState()=> HomeState();
}

class HomeState extends State<Home> {
  RefreshController _refreshController = new RefreshController();
  void _onRefresh(bool up){
		if(up){		   
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        _refreshController.sendBack(true, RefreshStatus.failed);
      });  
		}
		else{
			//footerIndicator Callback
		}
  }
  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
  }    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        automaticallyImplyLeading: false,//无返回箭头
      ),
      body:
      
      new SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onOffsetChange: _onOffsetCallback,
        child: 
        new ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: new EdgeInsets.all(1.0),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                new Column(
                  crossAxisAlignment:CrossAxisAlignment.stretch,//头部折叠
                  children: <Widget>[
                    new Container(
                      height: 200.0,
                      color: Colors.yellow,
                    ),
                    new Container(
                      height: 200.0,
                      color: Colors.red,
                    )
                  ],
                ),
              ]
        )        
      )       
    );
  }
}