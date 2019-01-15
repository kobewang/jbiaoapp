import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:jbiaoapp/config/api.dart';
import 'package:jbiaoapp/config/constants.dart';
import 'package:jbiaoapp/pages/detail.dart';
import 'package:jbiaoapp/util/NetUtils.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
const int PRICE_INDEX = 0;
const int TYPE_INDEX = 0;
const int ORDER_INDEX = 0;
const ORDERS = [
  {"title": "综合排序","id": 0},
  {"title": "最新","id": 1},
  {"title": "人气","id": 2},
  {"title": "推荐","id": 3}
];

const PRICES = [
  {"title": "所有","id": 0},
  {"title": "<1万","id": 1},
  {"title": "1-3万","id": 2},
  {"title": "3-5万","id": 3},
  {"title": "5-10万","id": 4},
  {"title": ">10万","id": 5},
];
const  TYPES = [
{"title": "全部分类", "id": 0},
{"title": "01.化学原料", "id": 1},
{"title": "02.颜料油漆", "id": 2},
{"title": "03.日化用品", "id": 3},
{"title": "04.燃料油脂", "id": 4},
{"title": "05.医药卫生", "id": 5},
{"title": "06.五金金属", "id": 6},
{"title": "07.机械设备", "id": 7},
{"title": "08.手工器械", "id": 8},
{"title": "09.科学仪器", "id": 9},
{"title": "10.医疗器械", "id": 10},
{"title": "11.家用电器", "id": 11},
{"title": "12.运输工具", "id": 12},
{"title": "13.军用烟花", "id": 13},
{"title": "14.珠宝钟表", "id": 14},
{"title": "15.乐器", "id": 15},
{"title": "16.文化用品", "id": 16},
{"title": "17.橡胶制品", "id": 17},
{"title": "18.皮革皮具", "id": 18},
{"title": "19.建筑材料", "id": 19},
{"title": "20.家具", "id": 20},
{"title": "21.家用器具", "id": 21},
{"title": "22.绳网袋篷", "id": 22},
{"title": "23.纺织纱线", "id": 23},
{"title": "24.床单布料", "id": 24},
{"title": "25.服装鞋帽", "id": 25},
{"title": "26.花边拉链", "id": 26},
{"title": "27.地毯席垫", "id": 27},
{"title": "28.体育玩具", "id": 28},
{"title": "29.食品罐头", "id": 29},
{"title": "30.调味茶糖", "id": 30},
{"title": "31.水果花木", "id": 31},
{"title": "32.啤酒饮料", "id": 32},
{"title": "33.酒", "id": 33},
{"title": "34.烟草烟具", "id": 34},
{"title": "35.广告贸易", "id": 35},
{"title": "36.金融物管", "id": 36},
{"title": "37.建筑修理", "id": 37},
{"title": "38.通讯电信", "id": 38},
{"title": "39.运输旅行", "id": 39},
{"title": "40.材料处理", "id": 40},
{"title": "41.教育娱乐", "id": 41},
{"title": "42.科研服务", "id": 42},
{"title": "43.餐饮酒店", "id": 43},
{"title": "44.医疗园艺", "id": 44},
{"title": "45.社会法律", "id": 45},
];

class TmListPage extends StatefulWidget {
  @override
  createState() => TmListPageState();
}

class TmListPageState extends State<TmListPage> {
  final TextEditingController controller = new TextEditingController();
  Widget searchBar() {
  return new Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Expanded(
        child: Card(                
          child: Container(
            height: 20.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: 200.0,                  
                  child: Center(
                    child: Form(
                      autovalidate: false,
                      child: 
                      new Column(
                        children: <Widget>[
                        TextField(
                          style:
                            new TextStyle(color: Colors.teal),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration.collapsed(
                                fillColor: Colors.white,                   
                                hintText: '输入商标名称或注册号',
                                hintStyle: TextStyle(fontSize: 12.0,color: Colors.black45),                                            
                                filled: false,                             
                              ),
                          onChanged: (String content){
                            setState(() {
                              keyWords = content;                              
                            });
                          },
                          onSubmitted: (String content){
                            keySearch(content);
                          }, 
                          controller: controller,                             
                          ),                          
                        ],
                      )                      
                    ),
                  ),
                )
              ],
              )         
            )                  
        )              
      ),
      new Container(
        margin: EdgeInsets.only(left: 0.0, right: 10.0),                                                
        height: 20.0,
        width: 50.0,                                                
        child:                      
          RaisedButton(                        
            color: Colors.orange,
            child: new Text("查询",style: TextStyle(fontSize: 12.0)),                                                                             
            padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,                        
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),                        
            onPressed: (){
               keySearch(keyWords);
            }
          )
        )                     
      ],
    );
  }  
  //头部drop
  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {    
    return new DropdownHeader(
      onTap: onTap,
      titles: [TYPES[TYPE_INDEX],PRICES[PRICE_INDEX],ORDERS[ORDER_INDEX]]
    );
  }
  //菜单drop
  DropdownMenu buildDropdownMenu() {
    return new DropdownMenu(
      maxMenuHeight: kDropdownMenuItemHeight*10,
      menus: [
        new DropdownMenuBuilder(
          builder: (BuildContext context) {
            return new DropdownListMenu(
              selectedIndex: TYPE_INDEX,
              data: TYPES,
              itemBuilder: buildCheckItem
            );
          },
          height: kDropdownMenuItemHeight * TYPES.length
        ),               
        new DropdownMenuBuilder(
          builder: (BuildContext context) {
            return new DropdownListMenu(
              selectedIndex: PRICE_INDEX,
              data: PRICES,
              itemBuilder: buildCheckItem,
            );
          },
          height: kDropdownMenuItemHeight * PRICES.length
        ),        
        new DropdownMenuBuilder(
          builder: (BuildContext context) {
            return new DropdownListMenu(
              selectedIndex: ORDER_INDEX,
              data: ORDERS,
              itemBuilder: buildCheckItem,
            );
          },
          height: kDropdownMenuItemHeight * ORDERS.length
        )       
      ],
    );
  }
  //listItemWidget构造
  Widget listItem(BuildContext context,int index) {
    var title = listData[index]['TmName'];
    //我是有底线的
    if(title == Constants.END_LINE_TAG) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('---  ${Constants.END_LINE_TAG}  ---')
        ],
      );
    }
    var itemWidget = 
    new Container(
      margin: EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      child:     
    new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //左边商标图
          Container(
            margin: EdgeInsets.all(5.0),
            child: new Image.network(listData[index]['TmImg'],width: 120.0,height: 90.0,fit: BoxFit.fill)
          ),
          //右边简介,4行
          Expanded(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(listData[index]['TmName'],style:TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        margin: EdgeInsets.only(left: 15.0,top: 3.0),
                        child: Text('注册号:${listData[index]['RegNo']}',style: TextStyle(fontSize: 10.0,color: Colors.grey)))
                      ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                        child: Text('分类:第${listData[index]['Type']}类',style: TextStyle(fontSize: 12.0))
                      )                      
                      ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Container(
                          width: 250.0,
                          child: 
                          Text(listData[index]['UseRange'],                        
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12.0,color: Colors.grey)
                          )        
                        )                                                       
                      ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[                
                      new Container(
                        margin: EdgeInsets.only(top: 2.0,right: 10.0),                                                
                        height: 20.0,
                        width: 50.0,                                                
                        child:                      
                        RaisedButton(                        
                          color: Colors.blue,
                          child: new Text("立即查看",style: TextStyle(fontSize: 10.0)),                                                                             
                          padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
                          highlightColor: Colors.blue[700],
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.grey,                                                  
                          onPressed: () {routeToDetail(listData[index]['Id']);},
                        )
                      )                     
                    ],
                  ),
                ],
              )
            )            
          )
        ],
      )      
      ]
    )
    );
    return InkWell(child: itemWidget,onTap: (){
      routeToDetail(listData[index]['Id']);  
    });
  }
  void routeToDetail(int tId) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new DetailPage(tmId: tId)));
  }
  var keyWords = '';
  var listData;
  var isNoMore = false;
  final int pageSize = 10;
  var tmType = 0;
  var minPrice = 0;
  var maxPrice = 0;
  var sortType = 0;
  var curPageIndex = 1;
  var totalCount = 0;
  //关键字搜索
  void keySearch(String keyStr) {
    keyWords = keyStr;
    curPageIndex = 1;
    getTmList();
  }
  RefreshController _refreshController;    
  void _onRefresh(bool up){
    print('*****isNoMore:$isNoMore');
	  if (up){      
      print('往下加载首页');
      curPageIndex = 1;
      getTmList();      
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
      getTmList();      
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
    getTmList();
  }
 //请求API
  getTmList() {
    String url = Api.TMLIST;    
    var postParam = {
    "pageListRequest": {
      "LastId": 0,
      "PageSize": pageSize,
      "Sort": "",
      "KeyWord": "",
      "PageIndex": curPageIndex
      },
    "Type": tmType,
    "PageIndex": curPageIndex,
    "KeyWord": keyWords,
    "Min": minPrice,
    "Max": maxPrice,
    "Years": 0,
    "ChType": 0,
    "ReType": "",
    "GroupIds": "",
    "SortType": sortType
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
          list1.add(json.decode('{"TmName":"${Constants.END_LINE_TAG}"}'));
        }
        else {
          isNoMore = false;          
        }        
        listData = list1;                     
      });    
    });
  }

  listItemWidgets() {
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
      child:new ListView.builder(
        physics: ScrollPhysics(),  
        shrinkWrap: true,
        itemCount: listData.length,
        itemBuilder: (context,index) { return listItem(context, index); },
        )
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: searchBar(),              
      ),
      body: new DefaultDropdownMenuController(
        onSelected:  ({int menuIndex, int index, int subIndex, dynamic data}) {
          //菜单选择
          print("menuIndex:$menuIndex index:$index subIndex:$subIndex data:$data");
          if(menuIndex == 0 ) {
            tmType = index;            
          } else if(menuIndex == 1) {
            switch(index) {
              case 0: minPrice=0;maxPrice=0;break;//所有
              case 1: minPrice=0;maxPrice=10000;break;//<1w
              case 2: minPrice=10000;maxPrice=30000;break;//1-3w
              case 3: minPrice=30000;maxPrice=50000;break;//3-5w
              case 4: minPrice=50000;maxPrice=100000;break;//5-10w
              case 5: minPrice=100000;maxPrice=1000000;break;//>10w
            }
          } else {
            switch(index) {
              case 0: sortType = 0; break;//综合排序
              case 1: sortType = 1; break;//最新
              case 2: sortType = 2; break;//人气
              case 3: sortType = 3; break;//推荐
            }
          }
          curPageIndex = 1;
          getTmList();
        },
        child: new Column(
          children: <Widget>[
            buildDropdownHeader(),            
            new Expanded(
              child: new Stack(
                children: <Widget>[
                  listItemWidgets(),
                  buildDropdownMenu()
                ],
              ),
            )
          ]
        )
      )     
    );
  }
}
