import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/config/api.dart';
import 'package:jbiaoapp/pages/webview.dart';
import 'package:jbiaoapp/util/NetUtils.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:jbiaoapp/widgets/searchbar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jbiaoapp/widgets/safetyservice.dart';
import 'package:jbiaoapp/widgets/carousel.dart';
import 'package:jbiaoapp/pages/detail.dart';

/**
 *首页
 */
class HomePage extends StatefulWidget {
  @override
  HomePageState createState()=> HomePageState();
}

class HomePageState extends State<HomePage> {
  List bannerList = [];
  List carouselList = [];
  String staticVisits="";
  String staticTmSum="";
  String staticSettled="";
  List tabNavList = [
    {
      'img':'images/tab_buy.png',
      'name':'买商标',
      'path':'/tmlist'
    },
    {
      'img':'images/tab_sell.png',
      'name':'卖商标',
      'path':'https://m.jbiao.cn/contact?from=app'
    },
    {
      'img':'images/tab_zhang.png',
      'name':'代理记账',
      'path':'https://m.jbiao.cn/contact?from=jizhang'
    },
    {
      'img':'images/tab_patent.png',
      'name':'申请专利',
      'path':'https://m.jbiao.cn/patent?from=jizhang'
    }
    ,
    {
      'img':'images/tab_query.png',
      'name':'商标查询',
      'path':'/tmlist'
    },
    {
      'img':'images/tab_write.png',
      'name':'我要出售',
      'path':'https://m.jbiao.cn/contact?from=app'
    },
    {
      'img':'images/tab_types.png',
      'name':'商标分类',
      'path':'https://m.jbiao.cn/xiaochengxu?from=app'
    },
    {
      'img':'images/tab_about.png',
      'name':'关于集标',
      'path':'/about'
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
  }
  getAdList() {
    String url = Api.INDEXAD;
    NetUtils.post(url, null).then((data){
      setState(() {
        var adList = json.decode(data)['Data']['List'];
        for(var i = 0; i < adList.length; i++){
          if(adList[i]['Location'] == 0)
            bannerList.add(adList[i]);
          else if(adList[i]['Location'] == 1)
            carouselList.add(adList[i]);
        }          
        staticVisits = json.decode(data)['Data']['Static']['Visits'];
        staticTmSum = json.decode(data)['Data']['Static']['TmSum'];
        staticSettled = json.decode(data)['Data']['Static']['Settled'];
      });
    });
  }
  @override
  void initState() {      
      _refreshController = new RefreshController();
      getAdList();
      super.initState();
    }
  //轮播baner  
  Widget bannerWidget() {
    if(bannerList.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new Container(
        height: 150.0,
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 5.0),
        child: new Swiper(itemBuilder: (BuildContext context, int index) {                            
          return new Image.network(bannerList[index]['AdImg'],fit: BoxFit.fill,);
        },
        pagination: new SwiperPagination(),
        control: new SwiperControl(), 
        itemCount: bannerList.length,
        autoplay: true,
        onTap: (index){ 
          if(bannerList[index]['RefId']>0)
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new DetailPage(tmId: bannerList[index]['RefId'])));              
        }
        )
      );
    }
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
                  new Text('总浏览量:'),new Text(staticVisits, style: TextStyle(color:Color(0xFFFFA500)))
                ],
              )                                                              
          ]),
          new Column(children: <Widget>[                        
              new Row(
                children: <Widget>[
                  new Text('总商标量:'),new Text(staticTmSum, style: TextStyle(color:Color(0xFFDB7093)))
                ],
              )                                                              
          ]),
          new Column(children: <Widget>[                        
              new Row(
                children: <Widget>[
                  new Text('总入驻量:'),new Text(staticSettled, style: TextStyle(color:Color(0xFF87CEEB)))
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
        itemBuilder: (BuildContext context,int index) {                                                        
          return gridItem(context,index);                            
        },                          
      )
    );
  }
    //图标navItem
  Widget gridItem(BuildContext context,int index) {    
     return GestureDetector(                               
      onTap: (){
        if(tabNavList[index]['path'].toString().contains('http'))
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new WebView(title: tabNavList[index]['name'].toString(),url: tabNavList[index]['path'].toString())
          ));
        else
        Navigator.pushNamed(context, tabNavList[index]['path'].toString());
      },
      child: new Container(                                                 
        child: new Column(                                                                        
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[                                                                                        
            new ClipOval(              
              //原形裁剪
              child: new SizedBox(                
                width: 40.0,
                height: 40.0,                
                child: Image.asset(tabNavList[index]['img'],fit:BoxFit.fill,color: Colors.blue),
              )
            ),                                      
            new Text(tabNavList[index]['name'],style: TextStyle(color: Color(0xFF757575),fontSize: 13.0,fontWeight: FontWeight.bold))                                      
          ],
        ),        
      ),
    );
  }
  //交易流程  
  Widget tranProcess() {
    return Container(
      color: Colors.white,
      height: 180.0,
      margin: EdgeInsets.only(bottom: 5.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Row(                        
            children: <Widget>[
              ClipRRect(                
                borderRadius: new BorderRadius.circular(1.0),
                child:Container(width: 6.0, height: 12.0, color: Colors.blue,margin: EdgeInsets.only(left: 5.0,right: 5.0),)
              ),
              Text('交易流程  /TRANSACTION PROCESS',style: TextStyle(fontSize: 12.0))
            ],
          ),
          Expanded(child: Image.asset('images/steps1.png',fit: BoxFit.fill))          
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: SearchBar(),        
         automaticallyImplyLeading: false //隐藏leading
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
        enablePullUp: false,
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
                    tranProcess(),
                    Carousel(picList:carouselList),
                    SafetyService(),                    
                  ],
                ),
              ]
        )   ))
    );    
  }
}

