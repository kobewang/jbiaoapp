import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/dao/tmDao.dart';
import 'package:jbiaoapp/model/regtmInfo.dart';
import 'package:jbiaoapp/pages/layout/result.dart';
import 'package:jbiaoapp/util/myDialog.dart';
import 'package:jbiaoapp/util/tmtypes.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:jbiaoapp/widgets/picker.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:image_picker/image_picker.dart';

/// 商标注册提交
///
///auth:wyj date:20190221
class RegtmPage extends StatefulWidget {
  @override
  createState() => RegtmPageState();
}

class RegtmPageState extends State<RegtmPage> {
  var hintStyle = TextStyle(color: Colors.grey, fontSize: 14.0); //提示样式
  var tmTypeStr = '';
  Future<File> _imageFile;
  File _yyzzImage;
  TextEditingController _tmNameCtrl = new TextEditingController();
  TextEditingController _tmRemarkCtrl = new TextEditingController();
  TextEditingController _tmApplyCtrl = new TextEditingController();
  TextEditingController _tmMobileCtrl = new TextEditingController();
  TextEditingController _tmAddrCtrl = new TextEditingController();
  List<PickerItem> listPickItem = [];

  @override
  initState() {
    super.initState();
   TmTypes.TYPES.forEach((item){
     var name = item['id'].toString()+'-'+item['title'].toString();
     listPickItem.add(new PickerItem(name:name,value: name));
   });
  }

  //表单行样式
  Widget rowItem(String title, Widget widget) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Theme.of(context).dividerColor))),
        child: Row(children: <Widget>[
          Container(
            width: 100,
            margin: EdgeInsets.only(left: 20.0, right: 10.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: widget)
        ]));
  }

  //行-商标名
  Widget rowTmName() {
    var widget = TextField(
      controller: _tmNameCtrl,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
          hintText: '请输入商标名称',
          hintStyle: hintStyle),
    );
    return rowItem('商标名称', widget);
  }

  //行-商标分类
  Widget rowTmType() {
    var widget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Picker(
            target: tmTypeStr == ''
                ? Text('选择行业分类', style: hintStyle)
                : Text(tmTypeStr),
            onConfirm: (PickerItem item) {
              setState(() {
                tmTypeStr = item.value.toString();
              });
            },
            items: listPickItem,
          ),
          Icon(Icons.arrow_drop_down)
        ]);
    return rowItem('行业分类', widget);
  }

  //行-备注
  Widget rowRemark() {
    var widget = TextField(
      maxLines: 2,
      controller: _tmRemarkCtrl,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
          hintText: '请输入备注',
          hintStyle: hintStyle),
    );
    return rowItem('申请备注', widget);
  }

  //行-申请人
  Widget rowApply() {
    var widget = TextField(
      controller: _tmApplyCtrl,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
          hintText: '请输入姓名',
          hintStyle: hintStyle),
    );
    return rowItem('申请人', widget);
  }

  //行-手机号
  Widget rowMobile() {
    var widget = TextField(
      controller: _tmMobileCtrl,
      maxLength: 11,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
          hintText: '请输入手机',
          hintStyle: hintStyle),
    );
    return rowItem('手机', widget);
  }

  var cityStr = '';
  //行-省份/城市/地区
  Widget rowCity() {
    Result resultAttr = new Result();
    PickerItem showTypeAttr = PickerItem(name: '省+市+县', value: ShowType.pca);
    var widget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child:
                cityStr == '' ? Text('请选择', style: hintStyle) : Text(cityStr),
            onTap: () async {
              Result tempResult = await CityPickers.showCityPicker(
                  context: context,
                  locationCode: resultAttr != null
                      ? resultAttr.areaId ??
                          resultAttr.cityId ??
                          resultAttr.provinceId
                      : null,
                  showType: showTypeAttr.value,
                  barrierOpacity: 0.5,
                  barrierDismissible: false);
              if (tempResult == null) {
                return;
              }
              this.setState(() {
                cityStr = tempResult.provinceName +
                    '-' +
                    tempResult.cityName +
                    '-' +
                    tempResult.areaName;
              });
            },
          ),
          Icon(Icons.arrow_drop_down)
        ]);
    return rowItem('省-市-区', widget);
  }

  //行-地址
  Widget rowAddr() {
    var widget = TextField(
      controller: _tmAddrCtrl,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
          hintText: '请输入详细地址',
          hintStyle: hintStyle),
    );
    return rowItem('地址', widget);
  }

  //行-图片上传标题
  Widget rowUploadTitle() {
    return rowItem('上传营业执照', Container(width: 0, height: 0));
  }

  //行-图片上传
  Widget rowUpload() {
    //上传营业执照
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Theme.of(context).dividerColor))),
        child: Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //上传按钮
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
                  Container(
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                          border: new Border.all(color: Colors.grey, width: 1),
                          color: Colors.white,
                          shape: BoxShape.rectangle),
                      child:
                          _imageFile == null ? addImageBtn() : previewImage()),
                  //样图
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0),
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                          border: new Border.all(color: Colors.grey, width: 1),
                          color: Colors.white,
                          shape: BoxShape.rectangle),
                      child: Image.network(
                          'https://www.jbiao.cn/images/营业执照上传样图.jpg',
                          fit: BoxFit.fill),
                    ),
                    onTap: () {
                      setState(() {
                        isPicShow = true;
                      });
                    },
                  )
                ]),
              ],
            )));
  }

  //上传按钮
  Widget addImageBtn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 40),
            child: Text('请上传营业执', style: hintStyle)),
        Text('照复印件盖章', style: hintStyle),
        Container(
            margin: EdgeInsets.only(top: 10),
            width: 100,
            height: 20,
            child: FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text('上传图片'),
              onPressed: () {
                _pickImage();
              },
            ))
      ],
    );
  }

  //图片预览
  Widget previewImage() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          _yyzzImage = snapshot.data;
          return InkWell(
            child: Image.file(snapshot.data, fit: BoxFit.fill),
            onTap: () {
              _pickImage();
            },
          );
        } else
          return addImageBtn();
      },
    );
  }

  _pickImage() {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  //行-提交按钮
  Widget rowSubmit() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        width: 200,
        child: FlatButton(
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text('提交申请'),
            onPressed: () {
              _submitForm();
            }));
  }

  Future _submitForm() async {
    var tmName = _tmNameCtrl.value.text;
    var tmRemark = _tmRemarkCtrl.value.text;
    var tmApply = _tmApplyCtrl.value.text;
    var tmMobile = _tmMobileCtrl.value.text;
    var tmAddr = _tmAddrCtrl.value.text;
    if (tmTypeStr == '' || tmTypeStr.isEmpty) {
      MyDialog.showToast('请选择行业分类');
      return;
    }
    if (cityStr == '' || cityStr.isEmpty) {
      MyDialog.showToast('请选择省份-城市-地区');
      return;
    }
    if (tmName == '' || tmName.isEmpty) {
      MyDialog.showToast('请填写商标名称');
      return;
    }
    if (tmApply == '' || tmApply.isEmpty) {
      MyDialog.showToast('请填写申请人姓名');
      return;
    }
    if (tmMobile == '' || tmMobile.isEmpty) {
      MyDialog.showToast('请填写手机号');
      return;
    }
    if (tmAddr == '' || tmAddr.isEmpty) {
      MyDialog.showToast('请填写详细地址');
      return;
    }
    if (_yyzzImage == null) {
      MyDialog.showToast('请上传营业执照');
      return;
    }
    var regTmInfo = new RegTmInfo();
    regTmInfo.tmName = tmName;
    regTmInfo.reMark = tmRemark;
    regTmInfo.applyName = tmApply;
    regTmInfo.mobile = tmMobile;
    regTmInfo.address = tmAddr;
    regTmInfo.tmType = tmTypeStr;
    var arrList = cityStr.split('-');
    regTmInfo.province = arrList[0];
    regTmInfo.city = arrList[1];
    regTmInfo.area = arrList[2];
    var res = await TmDao.addRegTm(regTmInfo, _yyzzImage);
    if (res.data['Data'] == '成功') {
    var nextSize=Util.getPXSize(context, 26);
    var nextWidget=
    InkWell(
      child: RichText(
      text: TextSpan(
        text: '前往 ',
        style: TextStyle(fontSize: nextSize,color: Color(0xFF555555)),
        children: <TextSpan>[
          TextSpan(text: '出售列表',style: TextStyle(fontSize: nextSize,color: Color(0xFF2487da))),
          TextSpan(text: ' 查看详情',style: TextStyle(fontSize: nextSize,color: Color(0xFF555555))),
        ]
      ),
    ),
    onTap: (){ Navigator.pushNamed(context, '/my/tmlist'); },
    );
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=> ResultPage(
        resultState: true,
        tipStr: '提交成功，等待审核',
        nextWidget: nextWidget,
      )));
    } else {
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=> ResultPage(resultState: false,tipStr: res.data['Data'],nextWidget: null)));
    }
  }

  var isPicShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商标注册'),
        ),
        body: isPicShow
            ? GestureDetector(
                child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: new Image.network(
                      'https://www.jbiao.cn/images/营业执照上传样图.jpg',
                      fit: BoxFit.fill,
                    )),
                onTap: () {
                  setState(() {
                    isPicShow = false;
                  });
                },
              )
            : SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  rowTmName(),
                  rowTmType(),
                  rowRemark(),
                  rowApply(),
                  rowMobile(),
                  rowCity(),
                  rowAddr(),
                  rowUploadTitle(),
                  rowUpload(),
                  rowSubmit()
                ],
              )));
  }
}
