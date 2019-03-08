import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
/// 我的商标Info
///
/// auth:wyj date:20190308
class  MyTmDetailInfo {
  int id;
  String regno;
  String tmimg;
  int type;
  String typename;
  String tmname;
  String orgnizaiton;
  String applicantcn;
  String mobile;
  String province;
  String city;
  String area;
  String addresscn;
  String appdate;//申请日期
  String regdate;//公告日期
  String privateDate;//专用权期限
  List<MyGoodsInfo> mygoodsinfo;
  MyTmDetailInfo({this.id,this.regno,this.tmimg,this.type,this.typename,this.tmname,this.orgnizaiton,this.applicantcn,this.mobile,this.province,this.city,this.area,this.addresscn,this.appdate,this.regdate,this.privateDate,this.mygoodsinfo});
  factory MyTmDetailInfo.fromJson(Map<String,dynamic> json) {
    return MyTmDetailInfo(
      id: json['Id'],
      regno: json['RegNo'],
      tmimg: json['TmImg'],
      type: json['Type'],
      typename: json['TypeName'],
      tmname: json['TmName'],
      orgnizaiton: json['Orgnization'],
      applicantcn: json['ApplicantCn'],
      mobile: json['Mobile'],
      province: json['Province'],
      city: json['City'],
      area: json['Area'],
      addresscn: json['AddressCn'],
      appdate: json['AppDate'],
      regdate: json['RegDate'],
      privateDate: json['PrivateDate'],
      mygoodsinfo:(json['Goods'] as List).map((item){
        return MyGoodsInfo(goodscode: item['GoodsCode'],goodsname: item['GoodsName']);
      }).toList()
    );
  }
}

/// 我的商标-使用范围
///
///
class  MyGoodsInfo {
  String goodscode;
  String goodsname;
  MyGoodsInfo({this.goodscode,this.goodsname});
}