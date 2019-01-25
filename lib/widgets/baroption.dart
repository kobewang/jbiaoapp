import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart';
import 'package:share/share.dart';
import 'package:jbiaoapp/util/util.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
class BarOptionWidget extends StatelessWidget {
  final OptionControl control;
  @override
  BarOptionWidget(this.control);
  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton(
      onSelected: 
      (String value){
        print('control.url:${control.url}');
        switch(value){
          case 'share':Share.share(control.url);break;       
          case 'pyq':
            print('pyq朋友圈：');
            fluwx.WeChatScene scene = fluwx.WeChatScene.TIMELINE;           
              fluwx.share(WeChatShareTextModel(
              text: "text from fluwx",
              transaction: "transaction}",
              scene: scene
            )).then((data) {
            print(data);
          });
          break;
          case 'copy':Util.copy(control.url);break;
          case 'browser':Util.launchURL(control.url);break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        new PopupMenuItem(value: "share",child: Text('分享')),
        new PopupMenuItem(value: "pyq",child: Text('朋友圈')),
        new PopupMenuItem(value: "browser",child: Text('浏览器')),
        new PopupMenuItem(value: "copy",child: Text('复制')),
      ],
    );
  }
}

class OptionControl {
  String url = "https://example.com";
}
