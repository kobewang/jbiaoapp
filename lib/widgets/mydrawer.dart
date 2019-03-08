import 'package:flutter/material.dart';
import 'package:jbiaoapp/util/tmtypes.dart';
import 'package:jbiaoapp/model/tmsearchInfo.dart';
import 'package:jbiaoapp/util/tmtypes.dart';

class MyDrawer extends StatefulWidget {
  final callBack;
  MyDrawer({Key key, this.callBack}) : super(key: key);
  @override
  createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  List typeList = [];
  List priceList = [
    {'name': '5千以下', 'id': 5000, 'checked': 'off'},
    {'name': '5千-1万', 'id': 10000, 'checked': 'off'},
    {'name': '1万-3万', 'id': 30000, 'checked': 'off'},
    {'name': '3万-5万', 'id': 50000, 'checked': 'off'},
    {'name': '5万-10万', 'id': 100000, 'checked': 'off'},
    {'name': '待议价', 'id': 999999, 'checked': 'off'},
  ];
  List cbTypeList = [
    {'name': '中文', 'id': 0, 'checked': 'off'},
    {'name': '英文', 'id': 1, 'checked': 'off'},
    {'name': '图形', 'id': 2, 'checked': 'off'},
    {'name': '中文英文', 'id': 3, 'checked': 'off'},
    {'name': '中文图形', 'id': 4, 'checked': 'off'},
    {'name': '中英图形', 'id': 6, 'checked': 'off'}
  ];
  List lenList = [
    {'name': '1个字', 'id': 1, 'checked': 'off'},
    {'name': '2个字', 'id': 2, 'checked': 'off'},
    {'name': '3个字', 'id': 3, 'checked': 'off'},
    {'name': '4个字', 'id': 4, 'checked': 'off'},
    {'name': '5个字', 'id': 5, 'checked': 'off'},
    {'name': '5字以上', 'id': 6, 'checked': 'off'},
  ];
  CurvedAnimation curved; //曲线动画，动画插值，
  AnimationController controller; //动画控制器
  bool forward = true;
  bool typeOpen = false; //展开分类
  var itemFontStyle = TextStyle(color: Colors.black); //选框字体
  var onItemFontStyle = TextStyle(color: Color(0xFF3c7ee5)); //选框选中字体
  var itemBgColor = Color(0xFFf6f6f6); //选框背景
  var onItemBgColor = Color(0xFFe3edfb); //选框选中背景
  var menuTitleStyle = TextStyle(color: Color(0xFF323233), fontSize: 15);
  TextEditingController tmNameCtrl = new TextEditingController();
  TextEditingController tmRegCtrl = new TextEditingController();
  TextEditingController tmGroupCtrl = new TextEditingController();
  TextEditingController tmRangeCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    TmTypes.TYPES.forEach((item) {
      typeList.add({'name': item['title'], 'id': item['id'], 'checked': 'off'});
    });
  }

  //菜单标题
  Widget menuTitle(String title) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(left: 20.0, right: 10.0),
      child: Text(title, style: menuTitleStyle),
    );
  }

  //选块控件
  Widget itemSelectWidget(List listData, int index, bool singleSelect) {
    var isCheck = listData[index]['checked'] == 'on';
    return InkWell(
        onTap: () {
          setState(() {
            if (singleSelect) {
              if (!isCheck)
                listData.forEach((item) {
                  item['checked'] = 'off';
                });
            }
            listData[index]['checked'] = isCheck ? 'off' : 'on';
          });
        },
        child: Container(
            height: 30,
            width: 80,
            margin: EdgeInsets.only(bottom: 10),
            color: isCheck ? onItemBgColor : itemBgColor,
            child: Center(
                child: Text(listData[index]['name'],
                    style: isCheck ? onItemFontStyle : itemFontStyle))));
  }

  Widget drawListItem(String menuName, List listData, bool singleSelect) {
    //以两行计算
    List<Widget> listColumn = [];
    for (var j = 0; j < 2; j++) {
      List<Widget> listRow = [];
      for (var i = 0; i < 3; i++) {
        listRow.add(itemSelectWidget(listData, (j * 3 + i), singleSelect));
      }
      var column = new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: listRow,
          )
        ],
      );
      listColumn.add(column);
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            menuTitle(menuName),
          ]),
          listColumn[0],
          listColumn[1]
        ]);
  }

  //文字输入行
  Widget keywordsRow(String menuName, TextEditingController edtiController) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Theme.of(context).dividerColor))),
        child: Row(children: <Widget>[
          menuTitle(menuName),
          Expanded(
              child: TextField(
            controller: edtiController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                border: InputBorder.none,
                hintText: '可为空'),
          ))
        ]));
  }

  //按钮行
  Widget buttonRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      FlatButton(
        color: Color(0xFFfb5555),
        child: Text('重置', style: TextStyle(color: Colors.white)),
        onPressed: () {
          _resetClick();
        },
      ),
      FlatButton(
          color: Color(0xFF3c7ee5),
          child: Text('确认', style: TextStyle(color: Colors.white)),
          onPressed: () {
            _drawerSchClick();
          })
    ]);
  }

  //重置搜索
  _resetClick() {
    setState(() {
      typeList.forEach((item) {
        item['checked'] = 'off';
      });
      cbTypeList.forEach((item) {
        item['checked'] = 'off';
      });
      priceList.forEach((item) {
        item['checked'] = 'off';
      });
      lenList.forEach((item) {
        item['checked'] = 'off';
      });
      tmNameCtrl = new TextEditingController(text: '');
      tmRegCtrl = new TextEditingController(text: '');
      tmGroupCtrl = new TextEditingController(text: '');
      tmRangeCtrl = new TextEditingController(text: '');
    });
  }

  //高级搜索提交
  _drawerSchClick() {
    var typeChecked = '';
    var cbTypeChecked = '';
    int priceChecked = 0;
    int lenChecked = 0;
    typeList.forEach((item) {
      if (item['checked'] == 'on') typeChecked += item['id'].toString() + ',';
    });
    cbTypeList.forEach((item) {
      if (item['checked'] == 'on') cbTypeChecked += item['id'].toString() + ',';
    });
    priceList.forEach((item) {
      if (item['checked'] == 'on') priceChecked = item['id'];
    });
    lenList.forEach((item) {
      if (item['checked'] == 'on') lenChecked = item['id'];
    });
    var tmName = tmNameCtrl.value.text;
    var tmRegno = tmRegCtrl.value.text;
    var tmGroup = tmGroupCtrl.value.text;
    var tmRange = tmRangeCtrl.value.text;
    TmSearchInfo searchInfo = new TmSearchInfo(
        tmNameKey: tmName,
        tmRegnoKey: tmRegno,
        tmGroupKey: tmGroup,
        tmRangeKey: tmRange,
        tmTypes: typeChecked,
        cbTypes: cbTypeChecked,
        price: priceChecked,
        len: lenChecked);
    widget.callBack(searchInfo);
    Navigator.of(context).pop();
  }

  //国际分类选择快
  List<Widget> typeListWidget() {
    var listWidget = List<Widget>();
    for (var i = 0; i < 14; i++) {
      List<Widget> listRow = [];
      for (var j = 0; j < 3; j++) {
        listRow.add(itemSelectWidget(typeList, (i * 3 + j), false));
      }
      listWidget.add(new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: listRow));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
              height: 30,
              child: InkWell(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      menuTitle('商标分类'),
                      Container(child: typeOpen
                          ? Icon(Icons.keyboard_arrow_down)
                          : Icon(Icons.keyboard_arrow_up),
                          margin: EdgeInsets.only(right: 15),
                      )
                      
                    ]),
                onTap: () {
                  setState(() {
                    typeOpen = !typeOpen;
                  });
                },
              )),
          typeOpen
              ? Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: typeListWidget()))
              : Container(width: 0, height: 0),
          //价格
          Divider(height: 1, color: Colors.grey),
          drawListItem('价格', priceList, true),
          //组合
          Divider(height: 1, color: Colors.grey),
          drawListItem('组合', cbTypeList, false),
          //长度
          Divider(height: 1, color: Colors.grey),
          drawListItem('长度', lenList, true),
          //分组
          Divider(height: 1, color: Colors.grey),
          keywordsRow('商标名', tmNameCtrl),
          //分组
          Divider(height: 1, color: Colors.grey),
          keywordsRow('注册号', tmRegCtrl),
          //分组
          Divider(height: 1, color: Colors.grey),
          keywordsRow('类似群组', tmGroupCtrl),
          //分组
          Divider(height: 1, color: Colors.grey),
          keywordsRow('使用范围', tmRangeCtrl),
          //按钮
          Divider(height: 1, color: Colors.grey),
          buttonRow()
        ],
      ),
    );
  }
}
