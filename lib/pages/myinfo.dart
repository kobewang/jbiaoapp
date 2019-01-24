import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/widgets/triangleCliper.dart';

/**
 * 我的首页
 */
class MyInfoPage extends StatefulWidget {
  @override
  createState () => MyInfoPageState();
}

class MyInfoPageState extends State<MyInfoPage> {  
var titleTextStyle = new TextStyle(fontSize: 16.0);
//头像widget
Widget avatarContainer() {
  var avContainer= new Container(
        color: Colors.blue,
        height: 200.0,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[              
              new Image.asset("images/ic_avatar_default.png",width: 60.0),                                      
              new Text("点击头像登录",style: new TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
        ),
      );
  return new InkWell(
    child: avContainer,
    onTap: (){
      _showDialog();
    },
  ) ;     
}

_showDialog() {
   showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            title: new Text('提示'),
            content: new Text('功能暂未开放，敬请期待'),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  '取消',
                  style: new TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  '确定',
                  style: new TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
}

Widget listTitle(IconData icon,String title) {
  var listItem = ListTile(leading: new Icon(icon),title: new Text(title,style: titleTextStyle),trailing: new Icon(Icons.keyboard_arrow_right));
  return new InkWell(
    child: listItem,
    onTap: (){
      if(title=='关于我们')
        Navigator.pushNamed(context, '/about');
      else 
        _showDialog();
    },
  ) ;     
}
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        avatarContainer(),
        new Divider(height: 1.0),            
        listTitle(Icons.list,'我的商标'),
        new Divider(height: 1.0),
        listTitle(Icons.drafts,'发布求购'),
        new Divider(height: 1.0),
        listTitle(Icons.star,'我的关注'),
        new Divider(height: 1.0),
        listTitle(Icons.share,'邀请好友'),
        new Divider(height: 1.0),
        listTitle(Icons.info,'关于我们'),
      ]
    );
  }
}