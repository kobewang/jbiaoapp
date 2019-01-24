import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/pages/webview.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:jbiaoapp/config/api.dart';
import 'package:jbiaoapp/config/constants.dart';
import 'package:jbiaoapp/util/NetUtils.dart';

/**
 * 资讯列表
 */

class NewsPage extends StatefulWidget {
  @override
  createState ()=> NewsPageState();
}
class NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {
  final List tabList = [
    {"title": "商标资讯", "id": 1},
    {"title": "网站公告", "id": 0},
    {"title": "商标纠纷", "id": 2},
    {"title": "专利新闻", "id": 3},
    {"title": "商标问问", "id": 4},
    {"title": "法律法规", "id": 5},
    {"title": "商标文献", "id": 6},
    {"title": "商标注册", "id": 7},    
  ];
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: tabList.length,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title:  new TabBar(
            indicatorSize: TabBarIndicatorSize.label,//指示器大小计算方式
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: tabList.map((item) {
                return new Tab(text: item['title']);
              }).toList()),
          ),
          body: new TabBarView(
            children: tabList.map((item) {
              return NewsLists(typeId: item['id']);
            }).toList()
          ),            
      ),
    );          
  }
}

class NewsLists extends StatefulWidget {
  final int typeId;
  @override
  NewsLists({Key key, this.typeId}) : super(key: key);
  createState() => new NewsListsState();
}

class NewsListsState extends State<NewsLists> {
  var listData;
  var isNoMore = false;
  final int pageSize = 10;
  var curPageIndex = 1;
  var totalCount = 0;
  RefreshController _refreshController;    
  void _onRefresh(bool up){
    print('*****isNoMore:$isNoMore');
	  if (up){      
      print('往下加载首页');
      curPageIndex = 1;
      getNewsList();      
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {    
        //_refreshController.scrollTo(_refreshController.scrollController.offset+100.0);
        _refreshController.sendBack(true, RefreshStatus.completed);
        setState(() {});
      });      
    }
    else {
      print('往上加载下一页');
      if(isNoMore) {
        print('到底了 没有更多了..');
        setState(() {
         _refreshController.sendBack(false, RefreshStatus.completed);         
                });
        return;
      }
      curPageIndex++;
      getNewsList();      
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
    getNewsList();
  }

  //请求API
  getNewsList() {
    String url = Api.NEWSLIST;    
    var postParam = 
    {
      "pageListRequest": {
        "LastId": 0,
        "PageSize": pageSize,
        "Sort": "",
        "KeyWord": "",
        "PageIndex": 0
      },
      "Type": widget.typeId,
      "PageIndex": curPageIndex
    };
    NetUtils.post(url,postParam).then((data) {      
      setState(() {                        
        List list1 = new List();
        int totalCount = json.decode(data)['Data']['Count'];
        if(curPageIndex == 1){
          listData = null;
          listData = new List();
          list1 = json.decode(data)['Data']['List'];
        }
        else {                    
          list1.addAll(listData);
          list1.addAll(json.decode(data)['Data']['List']);             
        }
        if(totalCount <= list1.length) {          
          isNoMore = true;          
          list1.add(json.decode('{"Title":"${Constants.END_LINE_TAG}"}'));
        }
        else {
          isNoMore = false;          
        }        
        listData = list1;                     
      });    
    });
  }

  @override
  Widget build(BuildContext  context) {
    if (listData == null) {
      //无数据显示Loading
      return new Center(
        child: new CircularProgressIndicator()
      );
    } else {
    return new SmartRefresher(
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
      child:
        new ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context,index) {
            return buildListItem(context,index);
          },
        )
    );
    }
  }
  //构造listitem
  buildListItem(BuildContext context, int index) {
    var greyTextStyle = new TextStyle(fontSize: 12.0,color: Colors.grey);
    var title = listData[index]['Title'];
    //我是有底线的
    if(title == Constants.END_LINE_TAG) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('---  ${Constants.END_LINE_TAG}  ---')
        ],
      );
    }
    var id = listData[index]['Id'];
    var author = listData[index]['Author'];
    var picUrl = listData[index]['ImgUrl'];
    var addtime = listData[index]['Addtime'];    
    var views =  listData[index]['Views'].toString();
    var likes =  listData[index]['Likes'].toString();    
    var titleRow = new Container(              
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,      
        children: <Widget>[
        Expanded(
          child: new Container(        
            margin: EdgeInsets.only(right: 20.0,top: 2.0),
            child: Text(title,overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
          )
        ),
        new Container(
          width: 150.0,
          height: 100.0,
          child: new Image.network(picUrl,fit: BoxFit.fill,)
        )
        ])
    );         
    var timeRow = new Container(
      margin: EdgeInsets.only(top: 5.0,bottom: 3.0),
      child:new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Text(author, style:greyTextStyle),
                  new Container(
                    margin: EdgeInsets.only(left: 30.0),
                    child: Text(addtime+' 发布',style: greyTextStyle)
                  )                                                  
                ],
              )            
            ],
          ),
          new Column(
            children: <Widget>[
              Text(views+'阅读',style: greyTextStyle)
            ],
          )        
        ]
      )  
    );    
    var item = new Container(
      color: Colors.white,      
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[               
          titleRow,
          timeRow        
        ]
      )
    );
    return new InkWell(
      child: item,
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (ctx) => new WebView(title: title,url: 'https://m.jbiao.cn/news/${id}?from=app')
        ));
      }
    );      
  }
}