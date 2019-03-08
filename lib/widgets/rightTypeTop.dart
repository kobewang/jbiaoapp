import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/model/typeInfo.dart';
import 'package:jbiaoapp/util/eventBus.dart';
import 'package:jbiaoapp/util/util.dart';
/// 右侧顶部详细
/// 
/// auth:wyj date:20190131
class RightTypeTop extends StatefulWidget {
  TypeInfo typeInfo;
  bool isGroup = true;
  RightTypeTop({Key key, this.isGroup, this.typeInfo}):super(key:key);
  @override
  createState ()=> RightTypeTopState();
}
class RightTypeTopState extends State<RightTypeTop> {
  TypeInfo typeInfo =new TypeInfo(id: 1,name: '化学原料',summary: '用于工业、科学、摄影、农业、园艺和林业的化学品；未加工人造合成树脂；未加工塑料物质；肥料；灭火用合成物；淬火和焊接用制剂；保存食品用化学品；鞣料；工业用粘合剂。',groupList: []);
  @override
  void initState() {
    super.initState();
    if(widget.isGroup == false)
      this.typeInfo = widget.typeInfo;
      eventBus.on<TypeSelectEvent>().listen((TypeSelectEvent data) =>
        show(data.typeInfo)
      );
  }
  void show(TypeInfo info) {
    setState(() {
      typeInfo = info;      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width-4.0,
      margin: EdgeInsets.only(top: 5.0,bottom: 5.0,right: 2.0),
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
          boxShadow: [
          new BoxShadow(color: Colors.blue[300],offset: new Offset(1.0,1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.blue[300],offset: new Offset(-1.0,-1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.blue[300],offset: new Offset(1.0,-1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.blue[300],offset: new Offset(-1.0,1.0),blurRadius: 1.0),
          ]
      ),   
      child: 
        Container(color: Colors.white,child: 
           new Column(
             children: <Widget>[
              Text('第${Util.FormateType(typeInfo.id)}类 ${typeInfo.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0)),
              Expanded(child:           
                Container(child: 
                  Text(typeInfo.summary,maxLines:3,overflow: TextOverflow.ellipsis)
                )
              )
              ],
            ) 
        )
    );
  }
}

