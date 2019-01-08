import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:jbiaoapp/widgets/searchbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
class Home extends StatefulWidget {
  @override
  HomeState createState()=> HomeState();
}

class HomeState extends State<Home> {
  RefreshController _refreshController;  
  
  void _onRefresh(bool up){
	  if (up)
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {    
        _refreshController.scrollTo(_refreshController.scrollController.offset+100.0);
        _refreshController.sendBack(true, RefreshStatus.completed);
        setState(() {});
      });
    else {
      new Future.delayed(const Duration(milliseconds: 2009))
        .then((val) {                  
          setState(() {});
                  _refreshController.sendBack(false, RefreshStatus.idle);
        });
    }
  }
  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }
  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
  }
  @override
  void initState() {      
      _refreshController = new RefreshController();
      super.initState();
    }    
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: SearcBar(),
      ),
      body:  new Container(
        child: new SmartRefresher(
          headerBuilder: (context,mode) {
          return new ClassicIndicator(
            mode: mode,
            height: 45.0,
            releaseText: '松开手刷新',
            refreshingText: '刷新中',
            completeText: '刷新完成',
            failedText: '刷新失败',
            idleText: '下拉刷新',
          );
        },
        footerBuilder: (context,mode) {
          return new ClassicIndicator(
            mode: mode,
            height: 45.0,
            releaseText: '松开手刷新',
            refreshingText: '刷新中',
            completeText: '刷新完成',
            failedText: '刷新失败',
            idleText: '下拉刷新',
          );
        },
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,            
        onOffsetChange: _onOffsetCallback,
        child: new ListView(
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
                      height: 300.0,
                      child: new CarouselSlider(
                        items: [1,2,3,4,5].map((i) {
                          return new Builder(
                            builder: (BuildContext context) {
                              return new Container(
                                width: MediaQuery.of(context).size.width,
                                margin: new EdgeInsets.symmetric(horizontal: 5.0),                                
                                child: new ClipRRect(
                                  borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
                                  child: new Image.network('https://pic.mp.cc/upload/aggds/180912/83d0910183e530f6320e1741adb70823.jpg?imageView/2/w/1940',height: 300.0,fit:BoxFit.fill)
                                )                                                                
                              );
                            },
                          );
                        }).toList(),
                        height: 200.0,
                        autoPlay: true
                      ),
                    ),
                    new Container(
                      height: 200.0,
                      color: Colors.red,
                    ),
                        new Container(
                      height: 200.0,
                      color: Colors.red,
                    )
                  ],
                ),
              ]
        )   ))
    );    
  }
}
