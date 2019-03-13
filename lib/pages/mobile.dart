import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/dao/userDao.dart';
import 'package:jbiaoapp/util/myDialog.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:jbiaoapp/widgets/custominput.dart';
import 'package:jbiaoapp/widgets/vcodebutton.dart';
/// 手机认证
///
/// auth:wyj date:20190311
class  MobilePage extends StatefulWidget {
  String token;
  MobilePage({Key key,this.token}):super(key:key);
  @override
  createState()=> MobilePageState();
}
class MobilePageState extends State<MobilePage> {
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  String mobile='';
  int mcode=0;
  //获取验证码
  Future<bool> _getPhoneCode() async {
    mobile=_phoneController.value.text;
    if(mobile==''||mobile.isEmpty) {
      MyDialog.showToast('请输入手机号码');
      return false;
    }
    if(mobile.length!=11) {
      MyDialog.showToast('请输入正确的手机号码');
      return false;
    }
    var res =await UserDao.getMobileCode(mobile, widget.token);
    print(res.data);
    if(res.data['Code'].toString()!='0') {
      MyDialog.showToast(res.data['Header']['ErrorMessage']);
      return false;
    }
    mcode=res.data['Data']['Mid'];
    MyDialog.showToast('已发送');
    return true;
  }
  //提交绑定
  _submitBindPhone() async {
    if(mcode==0) {
      MyDialog.showToast('请先获取验证码');
      return;
    }
    var vcode=_codeController.value.text;
    if(vcode==''||vcode.isEmpty) {
      MyDialog.showToast('验证码不能为空');
      return;
    }
    var res =await UserDao.mobileBind(mobile,widget.token,vcode,mcode);
    print(res.data);
    if(res.data['Code'].toString()!='0') {
      MyDialog.showToast(res.data['Header']['ErrorMessage']);
      return;
    }
    Navigator.of(context).pushNamed('/index_my');
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text(
          '绑定手机号',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: Util.getPXSize(context, 36.0)),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
            top: Util.getPXSize(context, 50),
            left: Util.getPXSize(context, 60),
            right: Util.getPXSize(context, 60)),
        child: Center(
          child: Column(
            children: <Widget>[
              CustomInput(
                controller: _phoneController,
                iconPath: "images/login_icon_mobile.png",
                placeholder: "请输入手机号",
                maxLength: 11,
                keyboardType: TextInputType.number,
              ),
              CustomInput(
                controller: _codeController,
                iconPath: "images/login_icon_vcode.png",
                placeholder: "请输入验证码",
                keyboardType: TextInputType.number,
                maxLength: 4,
                rightChild: VCodeButton(
                  text: "获取验证码",
                  onPressed: _getPhoneCode,
                  countdownSecond: 60,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Util.getPXSize(context, 100.0)),
                height: Util.getPXSize(context, 90.0),
                width: Util.getPXSize(context, 630.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: FlatButton(
                    onPressed: _submitBindPhone,
                    child: Text(
                      "提交注册",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Util.getPXSize(context, 34.0)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }  
  
}
