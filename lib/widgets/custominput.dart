import 'package:flutter/material.dart';
import 'package:jbiaoapp/util/util.dart';

class CustomInput extends StatelessWidget {
  final String iconPath; //图标路径地址
  final Icon icon;
  final String placeholder; //占位符文字
  final TextEditingController controller;
  final Widget rightChild;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle textStyle;
  final TextStyle placeholderStyle;
  final bool borderLine;
  final int maxLength;

  CustomInput({
    Key key,
    this.controller,
    this.iconPath,
    this.icon,
    this.placeholder,
    this.rightChild,
    this.keyboardType,
    this.obscureText = false,
    this.textStyle,
    this.placeholderStyle,
    this.borderLine = true,
    this.maxLength=0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Util.getPXSize(context, 100),
      child: Row(
        children: <Widget>[
          Container(
              margin: icon == null && iconPath == null
                  ? null
                  : EdgeInsets.only(right: Util.getPXSize(context, 30)),
              child: icon != null
                  ? icon
                  : (iconPath == null || iconPath.isEmpty
                      ? null
                      : Image.asset(iconPath))),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: borderLine
                    ? Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(236, 236, 236, 1.0),
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: keyboardType,
                      controller: controller,
                      obscureText: obscureText,
                      maxLength: maxLength==0?999:maxLength,
                      maxLengthEnforced: false,
                      style: textStyle ??
                          TextStyle(
                            fontSize: Util.getPXSize(context, 28.0),
                            color: Colors.black,
                          ),
                      decoration: InputDecoration(
                          hintText: placeholder,
                          border: InputBorder.none,
                          counterText: '',
                          hintStyle: placeholderStyle ??
                              TextStyle(
                                fontSize: Util.getPXSize(context, 28.0),
                                color: Color(0xffb2b2b2),
                              )),
                    ),
                  ),
                  rightChild ?? Container()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
