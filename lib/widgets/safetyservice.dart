import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/widgets/triangleCliper.dart';
class SafetyService extends StatefulWidget {
  @override
  createState ()=> SafetyServiceState();
}
class SafetyServiceState extends State<SafetyService> {
  String safetyStr="集标网资金担保交易，在线下单，资金全程保障。";
  List safetyList =[
    {'id':1,'title':'资金保障','active':1,'image':'F1_sel.png'},
    {'id':2,'title':'售后保障','active':0,'image':'F2.png'},
    {'id':3,'title':'状态检测','active':0,'image':'F3.png'},
    {'id':4,'title':'自有商标','active':0,'image':'F4.png'},
  ];
  List<Widget> safetyWidgets() {
    List<Widget> listWgts = [];
    for(int i = 1; i<5; i++ ){   
      listWgts.add(
        GestureDetector(
        child:  
          Column(children: <Widget>[
              Image.asset('images/${safetyList[i-1]['image']}',width: 50.0,height: 50.0),
              Text(safetyList[i-1]['title']),
              new Triangle(myColor: safetyList[i-1]['active']==1?Colors.blue[400]:Colors.transparent)
          ]),
        onTap:(){ setState(() {
          switch(i){
            case 1:safetyStr="集标网资金担保交易，在线下单，资金全程保障。";break;
            case 2:safetyStr="过户不成功包退，一年免费商标状态跟踪提醒。";break;
            case 3:safetyStr="商标状态实时审核，有效监测，确认商标可售。";break;
            case 4:safetyStr="精选一手商标，持有人自有认证，安全可靠。";break;
          }
          for(int j=0;j<4;j++){
            if(j==(i-1)){
              safetyList[j]['active']=1;
              safetyList[j]['image']="F${(j+1)}_sel.png";
            }
            else {
              safetyList[j]['active']=0;
              safetyList[j]['image']="F${(j+1)}.png";
            }
          }
        }); }
        )
      );
    }
    return listWgts;
  }

  @override
  Widget build(BuildContext context) {  
  return new Container(
    margin: EdgeInsets.only(bottom: 5.0),        
    color: Colors.white,
    child: 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 5.0),        
          child: 
          new Row(
          children: <Widget>[    
            ClipRRect(                
              borderRadius: new BorderRadius.circular(1.0),
              child:Container(width: 6.0, height: 12.0, color: Colors.blue,margin: EdgeInsets.only(left: 5.0,right: 5.0),)
            ),
            Text('服务保障  /SAFETY SERVICES',style: TextStyle(fontSize: 12.0))                      
          ],
        )),
        new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: safetyWidgets()       
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[       
            Container(
              width: MediaQuery.of(context).size.width-10,  
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                boxShadow:  [
                  new BoxShadow(color: Colors.blue[400],offset: Offset(1.0,1.0),blurRadius: 1.0),
                  new BoxShadow(color: Colors.blue[400],offset: Offset(-1.0,-1.0),blurRadius: 1.0),
                  new BoxShadow(color: Colors.blue[400],offset: Offset(1.0,-1.0),blurRadius: 1.0),
                  new BoxShadow(color: Colors.blue[400],offset: Offset(-1.0,1.0),blurRadius: 1.0),
                ]
              ), 
              height: 30.0,         
              //color: Colors.blue,
              //margin: EdgeInsets.only(left: 2.0,right: 2.0,bottom: 5.0,top: 5.0),                        
              child:    Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(safetyStr,style: TextStyle(color: Colors.white))
            ])            
            )
          ],
        )
      ],
    )
  );
  }
}