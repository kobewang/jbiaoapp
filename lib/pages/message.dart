import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class MessagePage extends StatefulWidget {
  @override
  createState() => MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  Widget certPic(String picUrl,String topTitle,String bottomTitle) {
      return new Stack(
        children: <Widget>[
            //Container(child: new Image.network('http://www.360dlzx.com/upfiles/member/auth/395-2015042018105863.jpg',width: MediaQuery.of(context).size.width/2-20),
          Container(child: new Image.network(picUrl,width: MediaQuery.of(context).size.width/2-20),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.black,width: 1.0),
              //shape: BoxShape.circle,
              borderRadius: new BorderRadius.circular(2.0)
            ),
            )
          ,
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
  Widget showIcon(IconData iconData,String title) {
    return new Container(
      height: 100.0,   
      width: MediaQuery.of(context).size.width/3-20,
      //color: Colors.white,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
     Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('您需要提供一下材料，经济会为您准备交易材料')
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
            Text('转让成功后，您将获得')
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
      ],
      )
    );
    
  }
}