import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/widgets/bottombar.dart';
import 'package:timeline/model/timeline_model.dart';
import 'package:timeline/timeline.dart';

class DetailPage extends StatefulWidget {
  @override
  createState ()=> DetailPageState();
}



class DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin{
  TabController tabController;
    void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this
    );    
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }  

  final List<Tab> tmTabs = <Tab>[
    new Tab(text: '详细信息'),
    new Tab(text: '交易流程'),
    new Tab(text: '所需材料')
  ];

  Widget tmPicRow() {
  return
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            height: 200.0,
            child: Image.network('https://img.32.cn/Public/Images/201703/20170302125435-4105.jpg',fit: BoxFit.fill)
          ),                    
        ],
    );
}
//商标详情Row
Widget detailRow() {
  return Column(children: <Widget>[
    Container(
      height: 400.0,
      width: MediaQuery.of(context).size.width,
      child:
    ListView(children: <Widget>[
      ListTile(leading: Text('注册号：'),title: Text('222587155',style: TextStyle(color:Colors.grey))),
      Divider(height: 1.0,color: Colors.grey),
      ListTile(leading: Text('初审公告期号：'),title: Text('1579',style: TextStyle(color:Colors.grey))),
      Divider(height: 1.0,color: Colors.grey),
      ListTile(leading: Text('注册公告期号：'),title: Text('1579',style: TextStyle(color:Colors.grey))),
      ListTile(leading: Text('注册公告日期：'),title: Text('2017-12-01',style: TextStyle(color:Colors.grey))),
      ListTile(leading: Text('专用权期限：'),title: Text('2018-01-02至2019-02-05',style: TextStyle(color:Colors.grey))),
      ListTile(leading: Text('商标类型：'),title: Text('中文商标',style: TextStyle(color:Colors.grey))),
      ListTile(leading: Text('类似群组：'),title: Text('3401,3401,3401,3401,3401,3401,3401,3401,3401,3401',style: TextStyle(color:Colors.grey))),
      ListTile(leading: Text('使用范围：'),title: Text('咖啡,茶,茶饮料,糖果,蜂蜜,糕点,方便面,玉米花,冰淇淋,调味品',style: TextStyle(color:Colors.grey))),

    ])
    )
  ]);
}
//交易流程Row  
final List<TimelineModel> timeList = [
      TimelineModel(id: "1", description: "下单委托",title: "买家"),
      TimelineModel(id: "2", description: "评估交易风险,谈判确定价格",title: "经纪"),
      TimelineModel(id: "3", description: "支付定金",title: "买家"),
      TimelineModel(id: "4", description: "联系卖家工作，准备交易材料",title: "经纪"),
      TimelineModel(id: "5", description: "支付余款",title: "买家"),
      TimelineModel(id: "6", description: "整理三方材料，提交商标局",title: "经纪"),
];
Widget timeRow() {
  return Column(children: <Widget>[
    Container(
      height: 400.0,
      width: MediaQuery.of(context).size.width,
      child: 
        new TimelineComponent(
      timelineList: timeList,
        // lineColor: Colors.red[200], // Defaults to accent color if not provided
        // backgroundColor: Colors.black87, // Defaults to white if not provided
        // headingColor: Colors.black, // Defaults to black if not provided
        // descriptionColor: Colors.grey, // Defaults to grey if not provided
      )
    )
  ]);
}
//商标材料Row
//材料图片
  Widget certPic(String picUrl,String topTitle,String bottomTitle) {
      return new Stack(
        children: <Widget>[            
          Container(child: new Image.network(picUrl,width: MediaQuery.of(context).size.width/2-20),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.black,width: 1.0),
              //shape: BoxShape.circle,
              borderRadius: new BorderRadius.circular(2.0)
            ),
            ),
          new Positioned(
            left: 10.0,
            bottom: 10.0,
            child: Text(bottomTitle,style: TextStyle(fontSize: 16.0)),
          ),
          new Positioned(
            left: 10.0,
            top: 10.0,
            child: Text(topTitle),
          )
        ],
      );
  }
  //资质证明
  Widget showIcon(IconData iconData,String title) {
    return new Container(
      height: 100.0,   
      width: MediaQuery.of(context).size.width/3-20,
      //color: Colors.white, 这个颜色不能加，会和decoration冲突
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,                    
        boxShadow: [
          new BoxShadow(color: Colors.grey[300],offset: Offset(1.0,1.0),blurRadius: 5.0),
          new BoxShadow(color: Colors.grey[300],offset: Offset(-1.0,-1.0),blurRadius: 5.0),
          new BoxShadow(color: Colors.grey[300],offset: Offset(1.0,-1.0),blurRadius: 5.0),
          new BoxShadow(color: Colors.grey[300],offset: Offset(-1.0,1.0),blurRadius: 5.0),
        ]
      ),
      child:
      new Container(
        color: Colors.white,
        child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(iconData,color: Colors.orange[500],size:50.0),
          Text(title)
        ],
      )
      )       
    );
  }  
Widget fileRow() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(left:15.0,bottom: 10.0),
              child: Text('您需要提供一下材料，经济会为您准备交易材料')
            )            
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            certPic('http://www.360dlzx.com/upfiles/member/auth/395-2015042018105863.jpg','营业执照(加盖公章复印件)','企业用户'),
            certPic('http://www.360dlzx.com/upfiles/member/auth/395-2015042018105863.jpg','身份证(复印件)','个人用户')                  
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(left:15.0,top:10.0,bottom: 10.0),
              child:Text('转让成功后，您将获得')
            )
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            showIcon(Icons.account_balance_wallet, '商标注册证'),
            showIcon(Icons.assessment, '转让受理通知'),
            showIcon(Icons.account_box, '核准商标证明'),            
          ]
        )
      ]
  );
}

  @override
  Widget build(BuildContext context) {
    return 
    new 
    Scaffold(    
      bottomNavigationBar: BottomBar(),
      body: 
        new ListView(children: <Widget>[
          tmPicRow(),
          Divider(height: 10.0,color: Colors.grey),
          ListTile(leading: Text('商标名称：'),title: Text('优米-泰迪')),
          Divider(height: 1.0,color: Colors.grey),
          ListTile(leading: Text('商标分类：'),title: Text('第43类 餐饮住所')),
          Divider(height: 1.0,color: Colors.grey),
          ListTile(leading: Text('商标服务：'),title: Text('4301,4302,4303,4303,4303,4303,4303,4303')),
          Divider(height: 10.0,color: Colors.grey),                  
          Container(
            color: new Color(0xfff4f5f6),
            height: 38.0,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: false,                      
              controller: tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: tmTabs.map((item) {
                return item;
              }).toList(),
            ),                              
          ),
            Container(
                    height: 800.0,
                    width: MediaQuery.of(context).size.width,
                    child: TabBarView(
                      controller: tabController,
                      children: tmTabs.map((item) {
                        switch(item.text)
                        {
                          case '详细信息':return detailRow();        
                          case '交易流程':return timeRow();        
                          case '所需材料':return fileRow();        
                        }
                      
                      }).toList(),
                    )
                  )        
        ]
        )
    );
                            
             
  }
}