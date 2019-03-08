import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:jbiaoapp/config/constants.dart';
import 'package:jbiaoapp/dao/typesDao.dart';
import 'package:jbiaoapp/local/localStorage.dart';
import 'package:jbiaoapp/model/goodsSearchInfo.dart';
//import 'package:flutter_html_textview/flutter_html_textview.dart';
/// 商标类型搜索
///
/// auth:wyj date:201901331
class TypeSearchPage extends StatefulWidget {
  @override
  createState ()=> TypeSearchPageState();
}
class TypeSearchPageState extends State<TypeSearchPage> {
  String searchContent;
  String historyWords = '';
  String keyWord;
  final TextEditingController controller = new TextEditingController();
  List<GoodsSearchInfo> listInfo =[];
  var isSearching = false;
  var isNoResult = false;
  var isHideHistory = false;
  //从本地库中读取历史
  getHiswords() async {
    historyWords = await LocalStorage.get(Constants.TYPE_SEARCH_HISTORY);
  }

  void searchKey(String key)  async{
    var res = await TypesDao.goodsSearch(key);
    var historyWords = await LocalStorage.get(Constants.TYPE_SEARCH_HISTORY);
    setState(() {
      listInfo = res.data;  
      isSearching = false;
      isHideHistory = true;
      isNoResult = listInfo.length >0 ? false : true;
      if(listInfo.length>0) {
        String saveStr='';
        LocalStorage.remove(Constants.TYPE_SEARCH_HISTORY);
        if(historyWords == null) 
          saveStr='';
        else 
         saveStr= historyWords.toString();
        var listStr =  saveStr.split(',').map((item){print('item:$item'); return item;}).toList();        
        if(!listStr.contains(key)){
          saveStr=saveStr+','+key;
          print('saveStr:$saveStr');
          LocalStorage.save(Constants.TYPE_SEARCH_HISTORY, saveStr);
          //LocalStorage.remove(Constants.TYPE_SEARCH_HISTORY);
        }
      }
    });
  }
  ///搜索行
  Widget searchRow() {
    return new
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        height: 50.0,
        child: new Card(
          color: Color.fromRGBO(243, 243, 243, 0.6),
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: InputBorder.none,
                      hintText: '输入关键字',
                      prefixIcon: new Icon(Icons.search,size:16.0,color:Colors.grey),
                    ),
                    onChanged: (String content){
                      setState(() {
                        searchContent=content;  
                      });
                    },
                    onSubmitted: (String content){
                      keyWord=searchContent;
                      setState(() {
                       isSearching = true; 
                      });
                      searchKey(keyWord);
                    },
                    controller: controller,
                  )                  
                ),
                searchContent==null ? new Container(height: 0.0,width: 0.0): new IconButton(
                  padding: EdgeInsets.all(0.0),
                  iconSize: 16.0,
                  icon: new Icon(Icons.close),
                  onPressed: (){
                    setState(() {
                     listInfo =[];
                     isSearching=false;
                     isNoResult=false;
                     isHideHistory = false;
                     searchContent = '';
                     controller.text = ''; 
                    });
                  },
                )
              ],
            ),
          ),
        ),
      );
  }

  //搜索记录行
  Widget historyRow()  {
    getHiswords();
    var arr= historyWords!=null?historyWords.split(','):[];
    var widgetList =arr.map((item){ if(item!=null)  return  historyText(item);}).toList();
    return 
      Wrap(
        spacing: 2.0,//左右间距
        runSpacing: 3.0,//上下间距
        children:widgetList
      );
  }
  //历史记录文本样式
  Widget historyText(String text) {
    if(text=='') return Container(height: 0.0,width: 0.0);
    return
    GestureDetector(child: 
      Chip(
        label: Text(text),
      ),
      onTap: (){
        controller.text=text;//输入框显示关键字
        controller.selection=TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream,offset: text.length));//光标定位
        searchContent=text;
        keyWord=text;
        setState(() {
          isSearching = true; 
        });
        searchKey(keyWord);
      },
    );
  }
  //列表行
  Widget listRow() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: listInfo.length,
      itemBuilder: (context,index) {
        return 
        Container(
          color:  Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5.0),
          child: 
        new Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: listDetail(index)
        )
        );
      },
    );
  }
  //自定义关键字加红text
  Widget mySpannedText(String line ,String key){
    var index=line.indexOf(key);
    //开头
    if(index==0){
      return Text.rich(
        new TextSpan(
          text: key,
          style: new TextStyle(
            color: Colors.red,
            fontSize: 14.0,
            decoration: TextDecoration.none,
          ),
          children: <TextSpan>[
              new TextSpan(
                text: line.substring(key.length,line.length),
                style: TextStyle(color: Colors.black)
              )
          ]
        )
      );
    }
    //句尾
    else if(index>0&&index+key.length==line.length)
    {
      return Text.rich(
        new TextSpan(
          text: line.substring(0,index),
          style: new TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            decoration: TextDecoration.none,
          ),
          children: <TextSpan>[
              new TextSpan(
                text: key,
                style: TextStyle(color: Colors.red)
              )
          ]
        )
      );
    }
    //句中
    else {
        return Text.rich(
        new TextSpan(
          text: line.substring(0,index),
          style: new TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            decoration: TextDecoration.none,
          ),
          children: <TextSpan>[
              new TextSpan(
                text: key,
                style: TextStyle(color: Colors.red)
              ),
               new TextSpan(
                text: line.substring(index+key.length,line.length),
                style: TextStyle(color: Colors.black)
              )
          ]
        )
      );
    }
  }

   List<Widget> listDetail(index)  {
     List wigets = new List<Widget>();
     wigets.add(
       Container(
         color: Colors.white,
         width: MediaQuery.of(context).size.width,
         child: new Row(
          children: <Widget>[
            Container(child: 
              Text('第${listInfo[index].interType}类',style: TextStyle(color: Colors.blue[300])),
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.blue,width: 0.5),
                borderRadius: new BorderRadius.all(new Radius.circular(3.0))
              ),
             ),
            Container(child: Text('${listInfo[index].typeName}'),margin: EdgeInsets.only(left: 20.0),)
          ],
        )
       )   
    );
    for(int i=0;i <listInfo[index].listGoods.length; i++) {
       wigets.add( 
         new Row(
             children: <Widget>[
               Expanded(child: 
               Container(
                 child: 
                  mySpannedText('【${listInfo[index].listGoods[i].groupId}】 ${listInfo[index].listGoods[i].id} ${listInfo[index].listGoods[i].typeName}',keyWord),          
                 color: Colors.grey[200]
                 )
               )
            ]
       )
       );
    }
    return wigets;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 254, 1.0),
      appBar: new AppBar(
        title: Text('商标分类分组搜索')
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          searchRow(),
          isHideHistory?Container(height: 0.0,width: 0.0):historyRow(),
          Expanded(child: isSearching?CupertinoActivityIndicator(): isNoResult? Text('未搜索到相关结果，请换个关键词试试',style: TextStyle(color: Colors.blue))  : listRow()) //菊花加载条
        ],
      ) 
    );
  }
}