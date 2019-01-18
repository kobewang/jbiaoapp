import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class Carousel extends StatefulWidget {
  @override
  createState() => CarouselState();
}
Widget carouseSlider() {
  return new CarouselSlider(
        items: [1,2,3,4,5].map((i) {
          return new Builder(
            builder: (BuildContext context) {
              return new Container(
                width: MediaQuery.of(context).size.width,
                margin: new EdgeInsets.symmetric(horizontal: 5.0),                                
                child: new ClipRRect(
                  borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
                  child: new Image.network('https://pic.mp.cc/upload/aggds/180912/83d0910183e530f6320e1741adb70823.jpg?imageView/2/w/1940',height: 60.0,fit:BoxFit.fill)
                )                                                                
              );
            },
          );
        }).toList(),
        height: 100.0,
        autoPlay: true
      );
}

class CarouselState extends State<Carousel> {
  Widget build(BuildContext context) {
    return 
     new Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      height: 120.0,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            children: <Widget>[
              Container(width: 6.0, height: 12.0, color: Colors.blue,margin: EdgeInsets.only(left: 5.0,right: 5.0),),
              Text('本月特价  /HOT SALE',style: TextStyle(fontSize: 12.0))                      
            ],
          ),
          carouseSlider()          
        ]
      )
    );               
  }
}