import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class  GroupInfo {
  String id;
  String name;
  GroupInfo({this.id,this.name});
  factory GroupInfo.fromJson(Map<String, dynamic> json) {
    return GroupInfo(
      id: json['Id'],
      name: json['Name']
    );
  }
  
}