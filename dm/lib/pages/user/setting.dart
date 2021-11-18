import 'package:dmarketing/pages/user/user_setting.dart';
import 'package:flutter/material.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:dmarketing/elements/PermissionDeniedWidget.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/elements/signOut.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/models/Constant.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool enableUpdate = false;
  @override
  void initState() {
    _nameEditingController.text = Constant.userName.toString().replaceAll("null", "").toString();
    _emailEditingController.text = Constant.email.toString().replaceAll("null", "").toString();
    _mobileEditingController.text = Constant.userPhone.toString().replaceAll("null", "").toString();
    _locationEditingController.text = Constant.userAddress.toString().replaceAll("null", "").toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var userAuth = Provider.of<UserAuth>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        title: Text(
          translate("profile.info"),
          style: GoogleFonts.cairo(
              color: colorDark,fontWeight: FontWeight.bold,fontSize: width*0.05
          ),
        ),
        actions: [
          enableUpdate==true?
          GestureDetector(
              onTap: (){
                setState(() {
                  enableUpdate=!enableUpdate;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(translate("profile.save"),
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      color: appColor,fontSize: width*0.05
                  ),
              ),)
          ):IconButton(
            icon: Icon(Icons.edit,color: appColor,),
            onPressed: (){
              setState(() {
                enableUpdate=!enableUpdate;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.input,color: Colors.red,size: width*0.08,),
            onPressed: (){
              showAlertDialogSignOut(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width*0.07),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(translate("market.change_name")),
                SizedBox(height: height*0.01,),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1,color: Colors.black54)
                    ),
                    child: TextFormField(
                      controller: _nameEditingController,
                      textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
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
                      enabled: enableUpdate==false?false:true,
                    )),
                SizedBox(height: height*0.02,),
                Text(translate("market.change_mobile")),
                SizedBox(height: height*0.01,),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1,color: Colors.black54)
                    ),
                    child: TextFormField(
                      controller: _mobileEditingController,
                      keyboardType: TextInputType.phone,
                      textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
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
                      enabled: enableUpdate==false?false:true,
                    )),
                SizedBox(height: height*0.02,),
                Text(translate("market.change_email")),
                SizedBox(height: height*0.01,),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1,color: Colors.black54)
                    ),
                    child: TextFormField(
                      controller: _emailEditingController,
                      textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
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
                      enabled: enableUpdate==false?false:true,
                    )),
                SizedBox(height: height*0.02,),
                Text(translate("market.change_social")),
                SizedBox(height: height*0.01,),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1,color: Colors.black54)
                    ),
                    child: TextFormField(
                      controller: _socialEditingController,
                      textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
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
                      enabled: enableUpdate==false?false:true,
                    )),
                SizedBox(height: height*0.02,),
                Text(translate("market.change_location")),
                SizedBox(height: height*0.01,),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1,color: Colors.black54)
                    ),
                    child: TextFormField(
                      controller: _locationEditingController,
                      textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: ""
                      ),
                      enabled: enableUpdate==false?false:true,
                    )),
                SizedBox(height: height*0.01,),
                Align(
                  alignment: Alignment.centerLeft,
                  child:GestureDetector(
                    child: Container(
                        alignment: Alignment.center,
                        width: width*0.7-20,
                        height: height * 0.05,
                        padding: EdgeInsets.symmetric(horizontal: width*0.04),
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child:Row(
                          children: [
                            Text(translate("market.detremine_location"),
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold, color: colorWhite),
                            ),
                            Icon(Icons.location_pin,color: colorWhite,),
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(height: height*0.03,),
                Visibility(
                  visible: enableUpdate==true?true:false,
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: ()async{
                        if(_nameEditingController.text.toString().trim()==Constant.userName.toString().trim()&&
                            _emailEditingController.text.toString().trim()==Constant.email.toString().trim()&&
                            _locationEditingController.text.toString().trim()==Constant.userAddress.toString().trim()&&
                            _mobileEditingController.text.toString().trim()==Constant.userPhone.toString().trim()){
                          setState(() {
                            enableUpdate=false;
                          });
                        }else{
                          if(_nameEditingController.text.toString().trim().isNotEmpty&&
                              _emailEditingController.text.toString().trim().isNotEmpty&&
                              _mobileEditingController.text.toString().trim().isNotEmpty
                          ){
                            await userAuth.updateProfile(
                                context: context,
                                name: _nameEditingController.text.toString().trim(),
                                email: _emailEditingController.text.toString().trim(),
                                mobile: _mobileEditingController.text.toString().trim(),
                                address: _locationEditingController.text.toString().trim(),
                            );
                            setState(() {
                              enableUpdate=false;
                            });
                          }else{
                            showToast(translate("toast.field_empty"));
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: width*0.5,
                        height: height * 0.07,
                        padding: EdgeInsets.symmetric(horizontal: width*0.09,),
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Text(translate("profile.save"),
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, color: colorWhite,
                              fontSize: width*0.05
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate("market.change_payment_info"),
                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                    fontSize: width*0.05-2),),
                    Card(
                      elevation: 4,
                      clipBehavior: Clip.hardEdge,
                      shape:  BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IconButton(
                          onPressed: (){

                          }
                          , icon: Icon(Icons.edit,color: appColor,)),
                    ),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Image.asset("assets/icons/payment.png",
                fit: BoxFit.contain,height: height*0.09,
                width: width*0.8,)
              ],
            ),
          ],
        ),
      ),
    );
  }
  final TextEditingController _nameEditingController = new TextEditingController();
  final TextEditingController _mobileEditingController = new TextEditingController();
  final TextEditingController _emailEditingController = new TextEditingController();
  final TextEditingController _socialEditingController = new TextEditingController();
  final TextEditingController _locationEditingController = new TextEditingController();
}
