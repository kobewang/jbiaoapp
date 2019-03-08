import 'package:flutter/material.dart';
import 'package:jbiaoapp/dao/typesDao.dart';
import 'package:jbiaoapp/util/eventBus.dart';
import 'package:jbiaoapp/util/util.dart';
///左侧列表Item
class LeftTypeList extends StatefulWidget {
  bool isType = true;//组件是分类或分组
  List leftList = [];
  LeftTypeList({Key key,this.isType,this.leftList}):super(key:key);
  @override
  createState ()=> LeftTypeListState();
}
class LeftTypeListState extends State<LeftTypeList> {

void onCheckList(int index) {
    var listNew = [];
    widget.leftList.forEach((item){
      item['checked']='off';
      listNew.add(item);
    });
    listNew[index]['checked']='on';
    widget.leftList=listNew;
    _getTypeDetail(widget.isType? widget.leftList[index]['id'].toString(): widget.leftList[index]['title']);
  }

  _getTypeDetail(String typeId) async{
    if(widget.isType) {
      //分类
      var res = await TypesDao.detail(int.parse(typeId));
      eventBus.fire(new TypeSelectEvent(res.data));
    } else {
      //分组
      var resGoods = await TypesDao.goodsList(typeId);
      var resGroup= await TypesDao.groupDetail(typeId);
      eventBus.fire(new GroupSelectEvent(resGoods.data,resGroup.data));
    }
  }
  Widget listItem(context,index) {
    var showText = widget.isType? '${Util.FormateType(index+1)}${widget.leftList[index]['title']}':'${widget.leftList[index]['title']}';
    var item= 
      Container(
        margin: EdgeInsets.only(bottom: 3.0,top: 3.0,left: 1.0,right: 1.0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          boxShadow: [
          new BoxShadow(color: Colors.grey[300],offset: new Offset(1.0,1.0),blurRadius: 3.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(-1.0,-1.0),blurRadius: 3.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(1.0,-1.0),blurRadius: 3.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(-1.0,1.0),blurRadius: 3.0),
          ]
        ),
        child: 
        Container(
          color: widget.leftList[index]['checked']=='on' ? Colors.blue[300]:Colors.white,
          padding: EdgeInsets.only(bottom: 5.0,top: 5.0,left: 5.0),
          child: 
          Text(showText,style: TextStyle(color: widget.leftList[index]['checked']=='on'?Colors.white:Colors.black))
        )        
      );

    return GestureDetector(
      child: item,
      onTap: (){
        setState(() {
           onCheckList(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 90.0,
        height: MediaQuery.of(context).size.height,
        child: 
        new Column(
          children: <Widget>[
            Expanded(
              child: 
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.leftList.length,
                itemBuilder: (context,index) {
                  return listItem(context,index);
                },
              )
            )                    
          ],
        )
      );
  }

}
