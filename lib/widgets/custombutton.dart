import 'package:jbiaoapp/util/util.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double widthPx;
  final double heightPx;
  final double fontSizePx;
  final Color fontColor;
  final Color color;
  final VoidCallback onPressed;
  final String text;
  final bool isOutLine;
  final Color borderColor;//outlinebutton用

  const CustomButton({
    Key key,
    this.widthPx: 630.0,
    this.heightPx: 90.0,
    this.fontSizePx: 34.0,
    this.fontColor,
    this.color,
    this.onPressed,
    this.text,
    this.isOutLine:false,
    this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Util.getPXSize(context, heightPx),
      width: Util.getPXSize(context, widthPx),
      decoration: BoxDecoration(
        color: color ?? Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: 
      isOutLine?
      OutlineButton(
        onPressed: onPressed,
        borderSide:BorderSide(color: borderColor??Colors.blue),
        child: Text(
            text,
            style: TextStyle(
                color: fontColor ?? Colors.white,
                fontSize: Util.getPXSize(context, fontSizePx)),
          )
      )
      :FlatButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: fontColor ?? Colors.white,
                fontSize: Util.getPXSize(context, fontSizePx)),
          )),
    );
  }
}
