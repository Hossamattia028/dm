
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:dmarketing/helper/Database.dart';
import 'package:dmarketing/helper/checkUser.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/main.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:google_fonts/google_fonts.dart';

showAlertDialogSignOut(BuildContext context) {
  AlertDialog alert;
  Widget cancelButton = FlatButton(
    child: Text(translate("button.cancel"), style: GoogleFonts.cairo(fontSize: 15,fontWeight: FontWeight.bold),),
    onPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget okButton = new Align(
    alignment: Alignment.center,
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        color: appColor,
        child: Text(
          translate("button.ok"),
        style: GoogleFonts.cairo(fontSize: 17,fontWeight: FontWeight.bold,
        color: colorWhite),
        ),
        onPressed: () async {
          await DBProvider.db.deleteAll();
          Constant.id=null;
          Constant.userPhone=null;
          Constant.userName=null;
          Constant.token=null;
          Constant.kind=null;
          await checkUser();
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushReplacement(context, MaterialPageRoute(builder:
              (BuildContext context) => MyApp()));
        },
      ),
    ),
  );
  // set up the AlertDialog
  alert = AlertDialog(
    title: Text(
      translate("activity_setting.sure_signout"),
      style: GoogleFonts.cairo(fontSize: 17,fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    actions: [
      okButton,
      cancelButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}