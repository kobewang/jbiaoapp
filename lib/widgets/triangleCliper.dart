import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Triangle extends StatelessWidget {
  Color myColor;      
  Triangle({Key key,this.myColor}):super(key:key);       
  @override
  Widget build(BuildContext context) {
  return new ClipPath(
    clipper: new _TriangleCliper(),
    child:new SizedBox(
      width: 10.0,
      height:10.0,
      child:  Container(color: myColor),
    ) ,
  );
  }
}

class _TriangleCliper extends CustomClipper<Path>{
  _TriangleCliper();  
  @override
  Path getClip(Size size) {    
    Path path = new Path();    
    path.moveTo(0, size.height); //按坐标画，从起点到终点
    path.lineTo(size.width/2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();// 使这些点构成封闭的多边形
    return path;
  }
  @override
  bool shouldReclip(_TriangleCliper oldClipper) {
      return false;
  }
}