import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
const int PRICE_INDEX = 0;
const int TYPE_INDEX = 0;
const int ORDER_INDEX = 0;
const ORDERS = [
  {"title": "综合排序","id": 0},
  {"title": "人气","id": 1},
  {"title": "最新","id": 2},
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

class TmList extends StatefulWidget {
  @override
  createState() => TmListState();
}

class TmListState extends State<TmList> {

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
  Widget listItem(BuildContext context,int index) {
    return 
    new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //左边商标图
          Container(
            margin: EdgeInsets.all(5.0),
            child: new Image.network('https://img.32.cn/Public/Images/201703/20170302125435-4105.jpg',width: 120.0,height: 80.0,fit: BoxFit.fill)
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
                    children: <Widget>[Text('商标名称',style:TextStyle(fontWeight: FontWeight.bold))],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                        child: Text('分类:第6类',style: TextStyle(fontSize: 12.0))
                      )                      
                      ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[                 
                        Text('范围：可下载的影像文件，的范德萨发范德萨范德萨，范德萨范德萨范德萨范德萨',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.0,color: Colors.grey)
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
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),                        
                          onPressed: () => {},
                        )
                      )                     
                    ],
                  ),
                ],
              )
            )            
          )
        ],
      ),
      Divider(height: 50.0,color: Colors.black12,)
      ]
    );  
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('列表'),
      ),
      body: new DefaultDropdownMenuController(
        child: new Column(
          children: <Widget>[
            buildDropdownHeader(),            
            new Expanded(
              child: new Stack(
                children: <Widget>[
                  new ListView.builder(
                    physics: ScrollPhysics(),  
                    shrinkWrap: true,
                    itemCount: 30,
                    itemBuilder: (context,index) { return listItem(context, index); },
                  ),
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
