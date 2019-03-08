import 'package:json_annotation/json_annotation.dart';
import 'package:jbiaoapp/model/goodsInfo.dart';
@JsonSerializable()
class GoodsSearchInfo {
  String interType;
  String typeName;
  List<GoodsInfo> listGoods;
  GoodsSearchInfo({this.interType,this.typeName,this.listGoods});
  factory GoodsSearchInfo.fromJson(Map<String, dynamic> json) {
    return GoodsSearchInfo(
      interType: json['InterType'],
      typeName: json['TypeName'],
      listGoods: (json['GoodsList'] as List).map((item){
        return GoodsInfo(groupId: item['GroupId'], id: item['GoodsId'], typeId: '', typeName: item['GoodsName']);
      }).toList()
    );
  }
  
}