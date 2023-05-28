import 'package:flutter/material.dart';

class AlertWidgets{
  static void showLoaderDialog(BuildContext context,[String? message]) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator.adaptive(
              valueColor:AlwaysStoppedAnimation<Color>(Color(0xff7AB02A))),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text(message == null?"Loading...":message)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(child: alert, onWillPop: ()async=>false);
      },
    );
  }
}