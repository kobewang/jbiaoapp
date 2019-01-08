import 'package:flutter/material.dart';
class SearcBar extends StatelessWidget {
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
            Expanded(child: TextField(decoration: InputDecoration(border: InputBorder.none,hintText: '商标名/注册号/分类'))),
            Icon(Icons.mic,color: Colors.black54) //话筒
          ],
        ),
      )
      );
  }
}
