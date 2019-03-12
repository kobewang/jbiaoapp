import 'package:jbiaoapp/util/util.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatefulWidget {
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  const CustomOutlineButton({
    Key key,
    this.textColor,
    this.borderColor,
    this.onPressed,
    @required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  _CustomOutlineButtonState createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: OutlineButton(
        highlightedBorderColor: widget.borderColor ?? Colors.blue,
        borderSide: BorderSide(
          color: widget.borderColor ?? Colors.blue,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(5),
        ),
        textColor: widget.textColor ?? Colors.blue,
        padding: widget.padding ?? EdgeInsets.all(0),
        child: widget.child,
        onPressed: widget.onPressed,
      ),
    );
  }
}
