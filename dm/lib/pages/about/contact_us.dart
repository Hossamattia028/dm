import 'package:dmarketing/models/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/repository/aboutPagesProvider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class ContactUsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ContactUsPageState();
  }
}
class _ContactUsPageState extends State<ContactUsPage>{

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var aboutProvider = Provider.of<About>(context);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        iconTheme: IconThemeData(color: appColor),
        title: Text(translate("drawer.drawer_callus"),
        style: GoogleFonts.cairo(color: appColor,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: width*0.05,right: width*0.05,
        top: height*0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(translate("signup.username"),
            style: GoogleFonts.cairo(fontWeight: FontWeight.bold),),
            SizedBox(height: height*0.01,),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1,color: appColor)
                ),
                child: TextFormField(
                  textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
            SizedBox(height: height*0.02,),

            Text(translate("signup.phone"),
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),),
            SizedBox(height: height*0.01,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1,color: appColor)
                ),
                child: TextFormField(
                  textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                  controller: _mobilephoneController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
            SizedBox(height: height*0.02,),


            Text(translate("activity_setting.message"),
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),),
            SizedBox(height: height*0.01,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1,color: appColor)
                ),
                child: TextFormField(
                  textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                  controller: _thetopicController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  minLines: 4,
                  maxLines: 4,
                )),




            SizedBox(height: height*0.05,),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 45,
                width:width*0.6,
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  color: appColor,
                  minWidth:width*0.6 ,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(
                    translate("activity_setting.send"),
                    style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: width*0.05-1,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                  onPressed: () async {
                    if (_usernameController.text.toString().trim().isNotEmpty||
                        _mobilephoneController.text.toString().trim().isNotEmpty||
                        _emailController.text.toString().trim().isNotEmpty||
                        _thetopicController.text.toString().trim().isNotEmpty) {
                      await aboutProvider.sendContact(
                          msg: _thetopicController.text.toString().trim(),
                          name: _usernameController.text.toString().trim(),
                          mobile: _mobilephoneController.text.toString().trim(),
                          email: _emailController.text.toString().trim()).then((value) {
                        Navigator.of(context).pop();
                      });
                    } else {
                      showToast(translate("toast.field_empty"));
                    }
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobilephoneController = TextEditingController();
  final TextEditingController _thetopicController = TextEditingController();

}

