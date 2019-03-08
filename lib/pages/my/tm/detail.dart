import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jbiaoapp/dao/tmDao.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:jbiaoapp/widgets/custombutton.dart';
import 'package:jbiaoapp/model/mytm_detailInfo.dart';

/// 我的商标详情
///
/// auth:wyj date:20190305
class MyTmDetailPage extends StatefulWidget {
  int tmId = 0;
  MyTmDetailPage({Key key, this.tmId}) : super(key: key);
  @override
  createState() => MyTmDetailPageState();
}

class MyTmDetailPageState extends State<MyTmDetailPage> {
  var divderHeight = 20.0;
  MyTmDetailInfo detailInfo = null;
  //获取信息
  getDetail() async {
    print('**widget.tmId:${widget.tmId}');
    var res = await TmDao.myTmDetail(widget.tmId);
    print(res.data);
    setState(() {
      detailInfo = res.data;
    });
  }

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  //行-自定义card
  Widget rowCard(String menuName, Widget body) {
    return Card(
        child: Container(
      padding: EdgeInsets.only(
          left: Util.getPXSize(context, 60),
          right: Util.getPXSize(context, 60)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              height: Util.getPXSize(context, Util.getPXSize(context, 100)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: Util.getPXSize(context, 1),
                          color: Color.fromRGBO(236, 236, 236, 1.0)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(menuName,
                      style: TextStyle(
                          fontSize: Util.getPXSize(context, 30),
                          fontWeight: FontWeight.w100)),
                ],
              )),
          body
        ],
      ),
    ));
  }

  //行-商标详情
  Widget rowTmDetail() {
    var listTitle = [
      {'title': '商标名称', 'value': detailInfo.tmname},
      {'title': '注册号', 'value': detailInfo.regno},
      {'title': '申请时间', 'value': detailInfo.appdate},
      {'title': '公告日期', 'value': detailInfo.regdate},
      {'title': '到期日期', 'value': detailInfo.privateDate},
    ];
    return rowCard('商标信息', infoRowItem(listTitle, true));
  }

  //详情-行-item
  infoRowItem(listTitle, isPic) {
    List<Widget> listWidget = [];
    listTitle.forEach((item) {
      listWidget.add(Container(
          height: 30,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  item['title'],
                  style: TextStyle(color: Color(0xFF9b9b9b)),
                ),
                Text(item['value'])
              ])));
    });
    if (isPic) {
      //插入图片行
      listWidget.add(Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: Util.getPXSize(context, 1),
                      color: Color.fromRGBO(236, 236, 236, 1.0)))),
          margin: EdgeInsets.only(left: 20.0),
          child:
              //上传按钮
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                rowItemImg('商标样图', detailInfo.tmimg),
                rowItemImg('委托书', 'https://www.jbiao.cn/images/营业执照上传样图.jpg'),
              ])));
    }
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: divderHeight),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start, children: listWidget));
  }

  //行-图
  Widget rowItemImg(String title, String img) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Text(title), margin: EdgeInsets.only(bottom: 10, top: 10)),
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: new Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                  shape: BoxShape.rectangle),
              child: Image.network(img, fit: BoxFit.fill)),
        ]);
  }

  //行-分类分组
  Widget rowTypes() {
    return rowCard(
        '分类信息',
        Container(
            margin: EdgeInsets.only(bottom: divderHeight),
            child: Table(children: typesRowItemList())));
  }

  typesRowItemList() {
    List<TableRow> listWidget = [];
    for (var i = 0; i < detailInfo.mygoodsinfo.length; i++) {
      listWidget.add(TableRow(children: [
        Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text('${detailInfo.type}-${detailInfo.typename}',
                style: TextStyle(color: Color(0xFF9b9b9b)))),
        Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(detailInfo.mygoodsinfo[i].goodscode,
                style: TextStyle(color: Color(0xFF9b9b9b)))),
        Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(detailInfo.mygoodsinfo[i].goodsname,
                style: TextStyle(color: Color(0xFF9b9b9b)))),
      ]));
    }
    return listWidget;
  }

  //行-申请人信息
  Widget rowApply() {
    var listTitle = [
      {'title': '企业名称', 'value': detailInfo.orgnizaiton??''},
      {'title': '申请人', 'value': detailInfo.applicantcn??''},
      {
        'title': '行政区划',
        'value': '${detailInfo.province??''}-${detailInfo.city??''}-${detailInfo.area??''}'
      },
      {'title': '详细地址', 'value': detailInfo.addresscn??''},
      {'title': '联系电话', 'value': detailInfo.mobile??''},
    ];
    return rowCard('申请人信息', infoRowItem(listTitle, false));
  }

  //行-时间线
  Widget rowTimeline() {
    return Center(
      child: Text('data'),
    );
  }

  //行-操作按钮
  Widget rowButton() {
    return CustomButton(
      text: '续费',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商标详情'),
          actions: <Widget>[
            Column(children: <Widget>[
              Icon(Icons.phone, color: Colors.blue),
              Text('客服', style: TextStyle(color: Colors.blue))
            ])
          ],
          centerTitle: true,
        ),
        body: detailInfo == null
            ? CupertinoActivityIndicator()
            : ListView(
                children: <Widget>[
                  rowTmDetail(),
                  rowTypes(),
                  rowApply(),
                  //rowTimeline(),
                  //rowButton()
                ],
              ));
  }
}
