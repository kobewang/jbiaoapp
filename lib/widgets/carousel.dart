import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jbiaoapp/pages/detail.dart';
class Carousel extends StatefulWidget {
  List picList=[];  
  @override
  Carousel({Key key,this.picList}):super(key:key);
  createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  Widget carouseSlider() {    
  if(widget.picList.length>0){
  return new CarouselSlider(
        items: widget.picList.map((item) {
          print('item:${item}');
          return new Builder(
            builder: (BuildContext context) {
              return new GestureDetector(
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.symmetric(horizontal: 5.0),                                
                  child: new ClipRRect(
                    borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
                    child: new Image.network(item['AdImg'],height: 60.0,fit:BoxFit.fill)
                  )                                                                                
                ),
                onTap: (){
                  if(item['RefId']>0)
                  Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new DetailPage(tmId: item['RefId'])));              
                }
              );              
            },
          );
        }).toList(),
        height: 100.0,
        autoPlay: true
      );
  }
  else {
    return Container(child: null);
  }
}
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