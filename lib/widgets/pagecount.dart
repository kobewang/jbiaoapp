import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/// 分页总数显示
///
/// auth:wyj date:20190308
class PageCount extends StatelessWidget {
  int totalCount=0;
  PageCount({Key key,this.totalCount}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 10),
          child: RichText(
            text: TextSpan(
                text: '共',
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: ' ${totalCount} ',
                      style: TextStyle(color: Colors.blue)),
                  TextSpan(text: '个商标', style: TextStyle(color: Colors.black)),
                ]),
          ),
        ),
        Container(
          width: 0,
          height: 0,
        )
      ],
    );
  }
}
