import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:jbiaoapp/util/myDialog.dart';
import 'package:jbiaoapp/widgets/custombutton.dart';

/// 发布出售
///
/// auth:wyj date:20190313
class AddSellPage extends StatefulWidget {
  @override
  createState() => AddSellPageState();
}

class AddSellPageState extends State<AddSellPage> {
  var isAgree = true;
  TextEditingController tmNameCtrl = new TextEditingController();
  TextEditingController regNoCtrl = new TextEditingController();
  TextEditingController priceCtrl = new TextEditingController();
  TextEditingController cardNameCtrl = new TextEditingController();
  TextEditingController cardNumCtrl = new TextEditingController();
  // 显示style
  getTitleStyle(BuildContext context) {
    var leftTiteStyle = TextStyle(
        fontSize: Util.getPXSize(context, 30), color: Color(0xFF333333));
    return leftTiteStyle;
  }

  //hintstyle
  getRightHintStye(BuildContext context) {
    var rightTintStyle = TextStyle(
        fontSize: Util.getPXSize(context, 30), color: Color(0xFF999999));
    return rightTintStyle;
  }

  //弹窗提醒
  _showAlert(String intrStr) {
    MyDialog.showAlert(context, intrStr,
        okLabel: '我知道了', ok: () {}, cancel: () {});
  }

  //行-item
  rowItem(String leftStr, String intrStr, Widget rightWidget) {
    var leftTitle = Text(leftStr, style: getTitleStyle(context));
    var itemWidget = Container(
        height: Util.getPXSize(context, 100),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    leftTitle,
                    intrStr == ''
                        ? Container(height: 0, width: 0)
                        : GestureDetector(
                            child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Icon(Icons.report,
                                    color: Color(0xFF2487da), size: 14)),
                            onTap: () {
                              _showAlert(intrStr);
                            },
                          )
                  ]),
              rightWidget
            ]));
    return itemWidget;
  }

  //行输入控件
  rowItemWidget(String title, TextEditingController textCtrl) {
    var rightWidget = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 120,
            margin: EdgeInsets.only(right: 5),
            child: TextField(
              controller: textCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                border: InputBorder.none,
                hintText: '请填写$title',
                hintStyle: getRightHintStye(context),
              ),
            )),
      ],
    );
    return rowItem(title, '$title', rightWidget);
  }

  //行-分隔
  rowDivider() {
    return Divider(
        height: Util.getPXSize(context, 1), color: Color(0xFFececec));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布出售'),
        centerTitle: true,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10),
              child: Center(child: Text('说明')))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                  right: Util.getPXSize(context, 40),
                  left: Util.getPXSize(context, 40)),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  rowItemWidget('商标名称', tmNameCtrl),
                  rowDivider(),
                  rowItemWidget('商标注册号', regNoCtrl),
                  rowDivider(),
                  rowItemWidget('您的售价', regNoCtrl),
                  rowDivider(),
                  rowItemWidget('您的姓名', cardNameCtrl),
                  rowDivider(),
                  rowItemWidget('身份证号', cardNameCtrl),
                  rowDivider(),
                ],
              )),
          Container(
              margin: EdgeInsets.all(Util.getPXSize(context, 40)),
              child: Row(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        setState(() {
                          isAgree = !isAgree;
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: isAgree
                                  ? Icon(Icons.check,
                                      size: 10, color: Colors.white)
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 10,
                                      color: Colors.blue,
                                    )))),
                  Text('我已阅读并同意',
                      style: TextStyle(
                          fontSize: Util.getPXSize(context, 26),
                          color: Color(0xFF999999))),
                  Text('《交易协议》',
                      style: TextStyle(
                          fontSize: Util.getPXSize(context, 26),
                          color: Color(0xFF2487da)))
                ],
              )),
          Container(
              margin: EdgeInsets.only(
                  left: Util.getPXSize(context, 40),
                  right: Util.getPXSize(context, 40)),
              child: CustomButton(
                widthPx: 670,
                heightPx: 90,
                text: '提交',
                onPressed: () {
                  _submitClick();
                },
              ))
        ],
      ),
    );
  }

  _submitClick() async {
    var tmName=tmNameCtrl.value.text;
    var regNo=regNoCtrl.value.text;
    var price=priceCtrl.value.text;
    var cardName=cardNameCtrl.value.text;
    var cardNum=cardNumCtrl.value.text;
    if (tmName.isEmpty) {
      MyDialog.showAlert(context, '请输入商标名称');
      return;
    }
    if (regNo.isEmpty) {
      MyDialog.showAlert(context, '请输入商标注册号');
      return;
    }
    if (price.isEmpty) {
      MyDialog.showAlert(context, '请输入出售价');
      return;
    }
    if (cardName.isEmpty) {
      MyDialog.showAlert(context, '请输入姓名');
      return;
    }
    if (cardNum.isEmpty) {
      MyDialog.showAlert(context, '请输入身份证号');
      return;
    }
  }
}
