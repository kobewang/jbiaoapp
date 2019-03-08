import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class  GoodsInfo {
  String id;
  String typeId;
  String groupId;
  String typeName;
  GoodsInfo({this.id,this.typeId,this.typeName,this.groupId});
  factory GoodsInfo.fromJson(Map<String, dynamic> json) {
    return GoodsInfo(
      id: json['Id'],
      typeId: json['TypeId'],
      typeName: json['TypeName'],
      groupId:''
    );
  }
  factory GoodsInfo.fromJson2(Map<String, dynamic> json) {
    return GoodsInfo(
      id: json['GoodsId'],
      typeId: '',
      typeName: json['GoodsName'],
      groupId:json['GroupId'],
    );
  }
}