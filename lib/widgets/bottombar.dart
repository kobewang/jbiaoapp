import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
class BottomBar extends StatefulWidget {
  int tmId;
  String mobile;
  @override
  BottomBar({Key key,this.tmId,this.mobile}):super(key:key);
  createState ()=> BottomBarState();
}
class BottomBarState extends State<BottomBar> {
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
                          GestureDetector(
                            child: Text('联系客服',style: TextStyle(fontSize: 12.0,color: Colors.grey)),
                            onTap: (){                                                             
                              _launchURL('tel:${widget.mobile}');
                              print('联系客服:${widget.mobile}');
                            },
                          )                          
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
                  //color: Color(0XFFca0c16),
                  color: Colors.blue,
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
  _launchURL(url) async {  
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}