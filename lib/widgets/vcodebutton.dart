import 'dart:async';

import 'package:jbiaoapp/util/util.dart';
import 'package:flutter/material.dart';
import 'package:jbiaoapp/widgets/customoutlinebutton.dart';

class VCodeButton extends StatefulWidget {
  final String text;
  final int countdownSecond;
  final Future<bool> Function() onPressed;
  final Color color;
  final Color countdownColor;
  final double width;
  final double height;

  const VCodeButton({
    Key key,
    this.countdownSecond,
    this.onPressed,
    this.text,
    this.color,
    this.countdownColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  createState()=> VCodeButtonState();
}

class VCodeButtonState extends State<VCodeButton>
    with SingleTickerProviderStateMixin {
  var second = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = widget.color ?? Color.fromRGBO(36, 135, 218, 1.0);
    if (second > 0) {
      color = widget.countdownColor ?? Color.fromRGBO(135, 135, 135, 1.0);
    }
    return CustomOutlineButton(
      padding: EdgeInsets.all(0),
      width: widget.width ?? Util.getPXSize(context, 160),
      height: widget.height ?? Util.getPXSize(context, 50),
      textColor: color,
      borderColor: color,
      child: Center(
        child: Text(
          second > 0 ? "$second 秒" : widget.text,
          style: TextStyle(
            fontSize: Util.getPXSize(context, 28),
          ),
        ),
      ),
      onPressed: () {
        if (second > 0) {
          return;
        }
        if (widget.onPressed != null) {
          widget.onPressed().then((b) {
            if (b) {
              setState(() {
                second = widget.countdownSecond;
              });
              timer = Timer.periodic(Duration(seconds: 1), (t) {
                setState(() {
                  second = second - 1;
                });
                if (second < 1) {
                  timer.cancel();
                }
              });
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
