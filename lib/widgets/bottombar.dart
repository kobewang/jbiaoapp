import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    BottomAppBar(
        child: 
        new Container(
          height: 50.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: 
                Container(                  
                  child:  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.contact_phone,size: 16.0,color: Colors.grey),
                          Text('联系客服',style: TextStyle(fontSize: 12.0,color: Colors.grey))
                        ],
                      )                      
                    ]
                  )
                )
                ,flex: 1
              ),
              Expanded(child: 
                Container(                  
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.favorite,size: 16.0,color: Colors.grey),
                          Text('加入收藏',style: TextStyle(fontSize: 12.0,color: Colors.grey),)
                        ],
                      )                      
                    ]
                  )
                )
                ,flex: 1
              ),
              Expanded(child: 
                Container(
                  color: Color(0XFFca0c16),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('我要购买',style: TextStyle(color: Colors.white),)
                        ],
                      )
                      
                    ],
                  )
                )
                ,flex: 2
              ),
            ],
          ),
        )       
      );        
  }
}