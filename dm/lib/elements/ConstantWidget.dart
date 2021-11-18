import 'package:flutter/material.dart';

class ConstantWidget{
  static Future loadingData({@required BuildContext context}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: CircularProgressIndicator()),
      ),
    );
  }

}