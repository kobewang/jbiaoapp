import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:jbiaoapp/widgets/custombutton.dart';

/// 公用的操作结果页，成功或失败
///
/// auth:wyj date:20190301
class ResultPage extends StatefulWidget {
  bool resultState = true;
  String tipStr = '操作成功';
  Widget  nextWidget = null; //成功引导到下一页,失败则不需要传参
  ResultPage({Key key, this.resultState, this.tipStr,this.nextWidget}) : super(key: key);
  @override
  createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提交结果'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: Util.getPXSize(context, 200)),
            child: widget.resultState
                ? Image.asset('images/succeed.png')
                : Image.asset('images/fail02.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: Util.getPXSize(context, 55)),
            child: Text(widget.tipStr,
                style: TextStyle(
                    fontSize: Util.getPXSize(context, 36),
                    color: Color(0xFF333333))),
          ),
          Container(
              margin: EdgeInsets.only(top: Util.getPXSize(context, 56)),
              child: widget.resultState
                  ? (widget.nextWidget==null?Container(height: 0, width: 0):widget.nextWidget)
                  : CustomButton(
                      text: '返回重新提交',
                      widthPx: 300,
                      heightPx: 80,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ))
        ],
      )),
    );
  }
}
