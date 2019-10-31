import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarHelper {
  static show(context,
      {body, bgColor = Colors.greenAccent, status = 'success'}) {
    Widget icon;
    switch (status) {
      case 'warning':
        icon = Icon(
          Icons.warning,
          color: Colors.orangeAccent,
        );
        break;
      default:
        icon = Icon(
          Icons.check_circle,
          color: Colors.white,
        );
    }
    Flushbar(
      margin: EdgeInsets.all(5),
      borderRadius: 10,
      flushbarPosition: FlushbarPosition.BOTTOM,
      messageText: Text(
        body,
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: bgColor,
      icon: icon,
    )..show(context);
  }
}
