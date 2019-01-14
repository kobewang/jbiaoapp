import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  String title;
  String url;
  WebView({Key key,this.title,this.url}) : super(key:key);
  @override
  createState ()=> WebViewState();
}

class WebViewState extends State<WebView> {
  bool loading = true;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  
  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((state){

    });
    flutterWebviewPlugin.onStateChanged.listen((url){
      setState(() {
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(new Text(widget.title,style:new TextStyle(color: Colors.white)));
    if (loading) 
      titleContent.add(new Container(width: 50.0));
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}