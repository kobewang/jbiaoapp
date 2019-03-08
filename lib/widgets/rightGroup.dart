import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/dao/typesDao.dart';
import 'package:jbiaoapp/model/goodsInfo.dart';
import 'package:jbiaoapp/model/groupInfo.dart';
import 'package:jbiaoapp/model/typeInfo.dart';
import 'package:jbiaoapp/pages/groupes.dart';
import 'package:jbiaoapp/util/eventBus.dart';

/// 右侧分组列表
///
/// auth:wyj date:20190131
class RightGroup extends StatefulWidget {
  bool isGroup = true;
  String headStr = '';
  String groupId = "";
  RightGroup({Key key,this.isGroup,this.headStr,this.groupId}):super(key:key);
  @override
  createState ()=> RightGroupState();
}
class RightGroupState extends State<RightGroup> {
  TypeInfo typeInfo =new TypeInfo(id: 1,name: '商标分类',summary: '分类详细描述',groupList: []);
  List<GoodsInfo> goodsList = []; 

  void firstType() async {
    var res = await TypesDao.detail(1);
      setState(() {
        typeInfo = res.data;
      });
  }
  void firstGroup() async {
    print('widget.groupId:${widget.groupId}');
    var res = await TypesDao.goodsList(widget.groupId);
    setState(() {
      goodsList = res.data;
    });
  }
  @override
  void initState() {
    super.initState();
    if(widget.isGroup) {
      firstType();
      eventBus.on<TypeSelectEvent>().listen((TypeSelectEvent data) =>
        show(data.typeInfo)
      );
    } else {
      firstGroup();
      eventBus.on<GroupSelectEvent>().listen((GroupSelectEvent data) =>
        showGoodsList(data.goodsInfoList,data.groupInfo)
      );
    }
  }
  void showGoodsList(List<GoodsInfo> goodsInfoList,GroupInfo groupInfo) {
    if(mounted) {
      setState(() {
        goodsList=goodsInfoList;
        widget.headStr='【${groupInfo.id}】${groupInfo.name}';
      });
    }
  }
  void show(TypeInfo info) {
    if(mounted){
    setState(() {
      typeInfo = info;      
    });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.only(top: 5.0,bottom: 5.0,right: 2.0),
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
          boxShadow: [
          new BoxShadow(color: Colors.grey[300],offset: new Offset(1.0,1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(-1.0,-1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(1.0,-1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(-1.0,1.0),blurRadius: 1.0),
          ]
      ),   
      child: 
        Container(
          color: Colors.white,
          child: 
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.isGroup? (typeInfo.groupList.length+1):(goodsList.length+1),
            itemBuilder: (context,index){
              if(index==0) {
                return new Container(
                  margin: EdgeInsets.only(bottom: 2.0,left: 5.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Text( (widget.isGroup?'分组信息':widget.headStr),style: TextStyle(fontWeight: FontWeight.bold)),
                      Divider(color: Colors.grey,height: 1.0)
                    ],
                  )
                );
              } else {
                var groupId = widget.isGroup? typeInfo.groupList[index-1].id:goodsList[index-1].id;
                var groupName = widget.isGroup?typeInfo.groupList[index-1].name:goodsList[index-1].typeName;
                var item = new Container(
                  margin: EdgeInsets.only(bottom: 2.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Expanded(child: 
                            Text(groupId==''? '$groupName':'【$groupId】$groupName')
                          ),
                          widget.isGroup?(new Icon(Icons.arrow_right)):Container(height: 0.0,width: 0.0)
                        ],
                      ),
                      Divider(color: Colors.grey,height: 1.0)
                    ],
                  )
                );
                if(widget.isGroup) { //跳转到分组列表
                  return GestureDetector(
                    child: item,
                    onTap: (){
                          Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new GroupesPage(typeInfo: typeInfo,groupId: groupId)));
                    },
                  );
                } else {
                  return item;
                }
              }
            },
          )
        )
    );
  }
}

