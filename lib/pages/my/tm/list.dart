import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/pages/my/tm/detail.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:jbiaoapp/widgets/custombutton.dart';
import 'package:jbiaoapp/widgets/pagecount.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:jbiaoapp/dao/tmDao.dart';

/// 我的商标列表
///
/// auth:wyj date:20190301
class MyTmListPage extends StatefulWidget {
  @override
  createState() => MyTmListPageState();
}

class MyTmListPageState extends State<MyTmListPage> {
  bool isNoMore = false;
  int curPageIndex = 1;
  var list = [];
  var itemFontSize = 15.0;
  var totalCount = 0;
  var isNone = false;
  RefreshController _refreshController;
  void _onRefresh(bool up) {
    if (up) {
      print('往下加载首页');
      curPageIndex = 1;
      getTmList();
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        _refreshController.sendBack(true, RefreshStatus.completed);
      });
    } else {
      if (isNoMore) {
        print('到底了 没有更多了..');
        setState(() {
          _refreshController.sendBack(false, RefreshStatus.completed);
        });
        return;
      }
      curPageIndex++;
      getTmList();
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        setState(() {});
        _refreshController.sendBack(false, RefreshStatus.idle);
      });
    }
  }

  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }

  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
  }
  //初始化
  void initState() {
    _refreshController = new RefreshController();
    getTmList();
    super.initState();
  }

  getTmList() async {
    var res = await TmDao.myTmList(curPageIndex);
    print(res);
    print(res.data['Data']);
    setState(() {
      totalCount = res.data['Data']['Count'];
      if (totalCount > 0)
        list = res.data['Data']['List'];
      else
        isNone = true;
    });
  }

  //卡片-头
  Widget rowHeader(int index) {
    var typeId = list[index]['Type'].toString();
    var typeName = list[index]['TypeName'].toString();
    var leftWidget = Text('${typeId}类-${typeName}',
        style: TextStyle(fontSize: itemFontSize));
    var rightWidget = Text(list[index]['Status'],
        style: TextStyle(fontSize: itemFontSize, color: Colors.blue));
    return rowHeaderItem(true, leftWidget, rightWidget);
  }

  //卡片-头部底部-公用
  Widget rowHeaderItem(bool isHead, Widget leftWidget, Widget rightWidget) {
    return Container(
        padding: EdgeInsets.only(
            right: Util.getPXSize(context, 60),
            left: Util.getPXSize(context, 60)),
        height: Util.getPXSize(context, 100),
        decoration: BoxDecoration(
            border: isHead
                ? Border(
                    bottom: BorderSide(
                        width: Util.getPXSize(context, 1),
                        color: Color.fromRGBO(236, 236, 236, 1.0)))
                : Border(
                    top: BorderSide(
                        width: Util.getPXSize(context, 1),
                        color: Color.fromRGBO(236, 236, 236, 1.0)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[leftWidget, rightWidget],
        ));
  }

  //卡片-底部
  Widget rowFooter(int index) {
    var payStatus = list[index]['PayStatus'];
    var tmId = list[index]['Id'];
    var rightWidget = CustomButton(
        color: Colors.white,
        fontColor: Colors.blue,
        widthPx: 200,
        heightPx: 60,
        isOutLine: true,
        text: '查看详情',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return new MyTmDetailPage(tmId: tmId);
          }));
        });
    var leftWidget = CustomButton(
      color: payStatus == '已付款' ? Colors.green : Color(0xFFf5456c),
      widthPx: 200,
      heightPx: 60,
      text: payStatus,
    );
    return rowHeaderItem(false, leftWidget, rightWidget);
  }

  //卡片-主体
  Widget rowBody(int index) {
    return Container(
        height: 120,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(right: 30),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey[100],
                        width: Util.getPXSize(context, 1))),
                child: Image.network(list[index]['TmImg'],
                    width: 100, height: 100, fit: BoxFit.fill)),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                bodyRowItem('商标名称:', list[index]['TmName']),
                bodyRowItem('注册号：', list[index]['RegNo']),
                bodyRowItem('到期时间:', list[index]['Rexpire']),
              ],
            ))
          ],
        ));
  }

  //卡片-body-item
  Widget bodyRowItem(String title, String value) {
    var textStyle = TextStyle(fontSize: itemFontSize);
    return Container(
        height: 33,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: textStyle),
              Text(value, style: textStyle)
            ]));
  }

  //行-总数量
  rowCount() {
    return PageCount(
      totalCount: totalCount,
    );
  }

  //行-分页列表
  rowPageList() {
    return SmartRefresher(
        headerBuilder: (context, mode) {
          return new ClassicIndicator(
            mode: mode,
            height: 45.0,
            releaseText: '松开手刷新',
            refreshingText: '刷新中',
            completeText: '刷新完成',
            failedText: '刷新失败',
            idleText: '下拉刷新',
          );
        },
        footerBuilder: (context, mode) {
          return new ClassicIndicator(
            mode: mode,
            height: 45.0,
            releaseText: '松开手刷新',
            refreshingText: '刷新中',
            completeText: '刷新完成',
            failedText: '刷新失败',
            idleText: '下拉刷新',
          );
        },
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onOffsetChange: _onOffsetCallback,
        child: ListView.separated(
          itemBuilder: (_, i) {
            return Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                rowHeader(i),
                rowBody(i),
                rowFooter(i),
              ],
            ));
          },
          itemCount: list.length,
          separatorBuilder: (_, i) {
            return Container(
              height: Util.getPXSize(context, 20),
              color: Color(0xFFececec),
            );
          },
        ));
  }

  //没有记录
  noneRecord() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: Util.getPXSize(context, 250),
              bottom: Util.getPXSize(context, 50)),
          child: Image.asset('images/norecord.png'),
        ),
        Text('没有商标记录',
            style: TextStyle(
                color: Color(0xFF999999),
                fontSize: Util.getPXSize(context, 30))),
        Container(
            margin: EdgeInsets.only(top: Util.getPXSize(context, 30)),
            child: CustomButton(
                color: Color(0xFF68a6ed),
                text: '去注册一个',
                widthPx: 300,
                onPressed: () {
                  Navigator.pushNamed(context, '/regtm');
                }))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的商标'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            !isNone ? rowCount() : Container(width: 0, height: 0),
            Expanded(child: !isNone ? rowPageList() : noneRecord())
          ],
        ));
  }
}
