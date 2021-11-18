import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// var appColor = const Color(0xff188e8d);
// const Color appColor=Color(0xFF40a944);
Color appColor = const Color(0xff4515bf);
Color appColorTwo = const Color(0xff22046e);
var colorWhite= const Color(0xffffffff);
var colorDark =const Color(0xff000000);
var colorStar =const Color(0xffFFD27D);
var colorGreen = const Color(0xff29ff37);
var colorGold = const Color(0xfffbcb22);
var colorBronze = const Color(0xffbf755a);
var colorSliver = const Color(0xffaab9cc);

void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: appColor,
      textColor:colorWhite ,
      fontSize: 16.0,
    );
  }

