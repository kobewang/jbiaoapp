import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/dao/userDao.dart';
import 'package:jbiaoapp/model/userInfo.dart';
import 'package:jbiaoapp/widgets/triangleCliper.dart';

/**
 * 我的首页
 */
class MyInfoPage extends StatefulWidget {
  @override
  createState() => MyInfoPageState();
}

class MyInfoPageState extends State<MyInfoPage> {
  var titleTextStyle = new TextStyle(fontSize: 16.0);
  var isLogin = false;
  UserInfo userInfo = null;
  @override
  initState() {
    _isLogin();
    super.initState();
  }

  _isLogin() async {
    var uInfo;
    var login = await UserDao.isLogin();
    if (login) {
      var res = await UserDao.getUserInfo();
      uInfo = res.data;
    }
    setState(() {
      isLogin = login;
      userInfo = uInfo;
    });
  }

//头像widget
  Widget avatarContainer() {
    var avContainer = new Container(
      color: Colors.blue,
      height: 200.0,
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userInfo != null
                ? new Image.network(userInfo.headImg, width: 60.0)
                : new Image.asset("images/ic_avatar_default.png", width: 60.0),
            new Text(
              userInfo != null ? userInfo.name : "点击头像登录",
              style: new TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
    return new InkWell(
      child: avContainer,
      onTap: () {
        Navigator.of(context).pushNamed('/login');
      },
    );
  }

  _showDialog(String title) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            title: new Text('提示'),
            content: new Text(title),
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

  Widget listTitle(IconData icon, String title) {
    var listItem = ListTile(
        leading: new Icon(icon),
        title: new Text(title, style: titleTextStyle),
        trailing: new Icon(Icons.keyboard_arrow_right));
    return new InkWell(
      child: listItem,
      onTap: () {
          switch (title) {
            case '关于我们':
              Navigator.pushNamed(context, '/about');
              break;
            case '我的商标':
            print('我的商标');
              if (isLogin) {
                Navigator.pushNamed(context, '/my/tmlist');
              } else {
                _showDialog('请点击头像登录');
              }
              break;
            case '发布求购':
              _showDialog('功能暂未开放，敬请期待');
              break;
            case '我的关注':
              _showDialog('功能暂未开放，敬请期待');
              break;
            case '邀请好友':
              _showDialog('功能暂未开放，敬请期待');
              break;
            default:
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(children: <Widget>[
      avatarContainer(),
      new Divider(height: 1.0),
      listTitle(Icons.list, '我的商标'),
      new Divider(height: 1.0),
      listTitle(Icons.drafts, '发布求购'),
      new Divider(height: 1.0),
      listTitle(Icons.star, '我的关注'),
      new Divider(height: 1.0),
      listTitle(Icons.share, '邀请好友'),
      new Divider(height: 1.0),
      listTitle(Icons.info, '关于我们'),
    ]);
  }
}
