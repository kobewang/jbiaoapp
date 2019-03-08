import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/pages/typeSearch.dart';
///分组搜索头部，静态按钮，点击跳转到搜索页
///
///auth:wyj 20190211
class TopTypeSearch extends StatefulWidget {

  @override
  createState()=> TopTypeSearchState();
}

class TopTypeSearchState extends State<TopTypeSearch> {
  @override
  Widget build(BuildContext context) {
   return Card(
     child: Padding(
       padding: EdgeInsets.symmetric(horizontal: 15.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           Stack(children: <Widget>[
             GestureDetector(child: Icon(Icons.search,color:Colors.black54),onTap: (){})
           ]),
           SizedBox(width: 10.0),
           new Expanded(
             child: new OutlineButton(
               borderSide: new BorderSide(color:Theme.of(context).primaryColor),
               child: new Text('关键词',style:new TextStyle(color:Colors.grey)),
               onPressed: (){Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new TypeSearchPage()));},
             ),
           )
         ],
       ),
     ),
   );
  }
}