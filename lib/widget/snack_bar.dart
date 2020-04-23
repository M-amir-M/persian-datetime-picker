import 'package:flutter/material.dart';

class SnackbarHelper {
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
    final snackBar = SnackBar(
      content: Text('$body'),
      backgroundColor: bgColor,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
