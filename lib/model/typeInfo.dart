import 'package:json_annotation/json_annotation.dart';
import 'package:jbiaoapp/model/groupInfo.dart';
@JsonSerializable()
class TypeInfo {
  int id;
  String name;
  String summary;
  List<GroupInfo> groupList;
  TypeInfo({this.id,this.name,this.summary,this.groupList});
  factory TypeInfo.fromJson(Map<String, dynamic> json) { 
    return TypeInfo(
      id: json['Id'],
      name: json['Name'],
      summary: json['Summary']
    );    
  }  
}