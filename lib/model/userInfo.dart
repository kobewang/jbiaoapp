/// 用户Info
///
/// auth:wyj date:20190313
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class  UserInfo {
  //id
  int id;
  //头像
  String headImg;
  //姓名
  String name;
  //金币
  double coin;
  //总签到
  int checkTotal;
  //连续签到
  int checkContinue;
  //等级
  String grade;
  UserInfo({this.id,this.headImg,this.name,this.coin,this.checkTotal,this.checkContinue});
  factory UserInfo.fromJson(Map<String,dynamic> json){
    return UserInfo(
      id:json['Id'],
      headImg: json['HeadImg'],
      name: json['Name'],
      coin: json['Coin'],
      checkTotal: json['CheckTotal'],
      checkContinue: json['CheckContinue']
    );
  }
}
