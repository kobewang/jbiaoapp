import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:jbiaoapp/widgets/searchbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class HomePage extends StatefulWidget {
  @override
  HomePageState createState()=> HomePageState();
}

class HomePageState extends State<HomePage> {
  List bannerList = [
    {
    'img':'https://upimg.22.cn/show//ad/20180823/0-20180823163529550.jpg',
    'url':'https://www.22.cn'
    },
    {
    'img':'https://www.22.cn/UserFiles2014/image/zixun/20181010vip_am.jpg',
    'url':'https://www.22.cn'
    },
    {
    'img':'https://yun.22.cn/Yun2016/img/banner350.jpg',
    'url':'https://www.22.cn'
    },
  ];
  List tabNavList = [
    {
      'img':'https://github.com/luhenchang/flutter_study/blob/master/images/longnv5.jpeg?raw=true',
      'name':'域名',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/设计师.png',
      'name':'商标',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/制作加工.png',
      'name':'专利',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/染色.png',
      'name':'抢注',
      'path':''
    }
    ,
    {
      'img':'https://img.yms.cn/tabicon/店铺.png',
      'name':'拍卖',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/店铺.png',
      'name':'拍卖',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/店铺.png',
      'name':'拍卖',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/店铺.png',
      'name':'拍卖',
      'path':''
    }
  ] ;  
  RefreshController _refreshController;    
  void _onRefresh(bool up){
	  if (up)
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {            
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
  //轮播baner  
  Widget bannerWidget() {
    return new Container(
      height: 150.0,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: new Swiper(itemBuilder: (BuildContext context, int index) {                            
        return new Image.network(bannerList[index]['img'],fit: BoxFit.fill,);
      },
      pagination: new SwiperPagination(),
      control: new SwiperControl(), 
      itemCount: 3
      )
    );
  }
  //统计行
  Widget staticWidget() {
    return new Container(
      color: Colors.white,
      height: 20,
      margin: EdgeInsets.only(bottom: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(children: <Widget>[                        
              new Row(
                children: <Widget>[
                  new Text('总浏览量:'),new Text('26.4w', style: TextStyle(color:Color(0xFFFFA500)))
                ],
              )                                                              
          ]),
          new Column(children: <Widget>[                        
              new Row(
                children: <Widget>[
                  new Text('总商标量:'),new Text('56.4w', style: TextStyle(color:Color(0xFFDB7093)))
                ],
              )                                                              
          ]),
          new Column(children: <Widget>[                        
              new Row(
                children: <Widget>[
                  new Text('总入驻量:'),new Text('1.1w', style: TextStyle(color:Color(0xFF87CEEB)))
                ],
              )                                                              
          ]),
        ],    
      ),
    );
  }
  //grid tab 导航
  Widget gridtabWidget() {
    return new Container(
      color: Colors.white,
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 5.0),
      child: new GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(            
          crossAxisCount: 4,
          crossAxisSpacing: 3.0,          
          mainAxisSpacing: 3.0,
          childAspectRatio: 1.5 //宽高比
        ),        
        padding: EdgeInsets.only(top: 10.0),
        itemCount: tabNavList.length,                          
        //padding: const EdgeInsets.all(10.0),
        itemBuilder: (BuildContext context,int index) {                                                        
          return gridItem(context,index);                            
        },                          
      )
    );
  }
    //图标navItem
  Widget gridItem(BuildContext context,int index) {    
     return GestureDetector(                               
      onTap: (){},
      child: new Container(                                                 
        child: new Column(                                                                        
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[                                                                                        
            new ClipOval(              
              //原形裁剪
              child: new SizedBox(                
                width: 40.0,
                height: 40.0,
                child: new Image.network(tabNavList[index]['img'],fit:BoxFit.fill),                                          
              )
            ),                                      
            new Text(tabNavList[index]['name'],style: TextStyle(color: Color(0xFF757575),fontSize: 13.0,fontWeight: FontWeight.bold))                                      
          ],
        ),
        //margin: new EdgeInsets.only(left: 15.0,right: 15.0,bottom: 1.0,top: 1.0),
      ),
    );
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
              //padding: new EdgeInsets.all(1.0),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                new Column(
                  crossAxisAlignment:CrossAxisAlignment.stretch,//头部折叠
                  children: <Widget>[
                    bannerWidget(),
                    staticWidget(),
                    gridtabWidget(),
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
