import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/model/typeInfo.dart';
import 'package:jbiaoapp/util/tmtypes.dart';
import 'package:jbiaoapp/widgets/leftTypeList.dart';
import 'package:jbiaoapp/widgets/rightGroup.dart';
import 'package:jbiaoapp/widgets/rightTypeTop.dart';
import 'package:jbiaoapp/widgets/topTypeSearch.dart';
/// 商标分类表
///
/// auth:wyj date:20190131
class TypesPage extends StatefulWidget {
  @override
  createState ()=> TypesPageState();
}

class TypesPageState extends State<TypesPage> {
  TypeInfo typeInfo = new TypeInfo(id: 0,name: '商标分类',summary: '分类详细描述',groupList: []);
   List leftTypeList=[];
  @override
  void initState() {
    super.initState();
    setState(() {
      getTypes();      
    });
    
  }
  void getTypes() {
    TmTypes.TYPES.forEach((item){
      if( int.parse(item['id'].toString()) > 0 ) {
      if( int.parse(item['id'].toString()) == 1 )
        item['checked']='on';
      else
        item['checked']='off';
      leftTypeList.add(item);
      }
    });
  }
 
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(255, 255, 254, 1.0),
      appBar:new AppBar(
        title: TopTypeSearch(),
      ),
         body: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //左侧list
          LeftTypeList(isType: true,leftList: leftTypeList),
          //右侧list
          Expanded(child: 
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: 
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RightTypeTop(isGroup: true,),
                Expanded (child: 
                  RightGroup(isGroup: true)
                )
              ],
            )
          )
          )
        ],
      )
    );
  }
}