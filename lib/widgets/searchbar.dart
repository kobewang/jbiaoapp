import 'package:flutter/material.dart';
import 'package:jbiaoapp/pages/tmlist.dart';
class SearchBar extends StatefulWidget {
  
  @override
  createState ()=> SearchBarState();
}
class SearchBarState extends State<SearchBar> {
  FocusNode _focusNode = new FocusNode();  // 初始化一个FocusNode控件
  @override
  void initState() {      
      super.initState();
       _focusNode.addListener(_focusNodeListener);  // 初始化一个listener
  }
  @override
  void dispose(){
      _focusNode.removeListener(_focusNodeListener);  // 页面消失时必须取消这个listener！！
      super.dispose();
  }

  Future<Null> _focusNodeListener() async {  // 用async的方式实现这个listener
    if (_focusNode.hasFocus){
        Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new TmListPage(isLeading:true)));
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,//阴影大小
      margin: EdgeInsets.only(top: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0))
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              alignment: Alignment(2.4, -1.4),
              children: <Widget>[
                Icon(Icons.brightness_1,color: Colors.red,size: 14.0),//红点
                GestureDetector(child: Icon(Icons.search,color: Colors.black54),onTap: (){print('click');},),                
              ]
            ),
            SizedBox(width: 10.0),
            new Expanded(
            child: new OutlineButton(
              borderSide:new BorderSide(color: Theme.of(context).primaryColor),
              child: new Text('商标名/注册号/分类',style: new TextStyle(color: Colors.grey)),
              onPressed: (){Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new TmListPage(isLeading:true)));},
              )
            ),
            /*
            Expanded(
              child: 
              TextField(
                decoration: InputDecoration(border: InputBorder.none,hintText: '商标名/注册号/分类'),
                focusNode: _focusNode,
                onChanged: (String str){Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new TmListPage(isLeading:true)));}
              ),
            ),
            */
            Icon(Icons.mic,color: Colors.black54) //话筒
          ],
        ),
      )
      );
  }
}
