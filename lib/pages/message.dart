import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class MessagePage extends StatefulWidget {
  @override
  createState() => MessagePageState();
}
class MessagePageState extends State<MessagePage> {
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
            new Image.network('http://www.360dlzx.com/upfiles/member/auth/395-2015042018105863.jpg',width: MediaQuery.of(context).size.width/2-20),
            new Image.network('http://www.360dlzx.com/upfiles/member/auth/395-2015042018105863.jpg',width: MediaQuery.of(context).size.width/2-20),
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
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.file_download),
                Text('dddd')
              ],
            )
          ]
        )
      ],
      )
    );
    
  }
}