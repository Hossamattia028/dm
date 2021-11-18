import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/repository/market/auth_merchant.dart';

class SocialMediaSetting extends StatefulWidget {
  const SocialMediaSetting({Key key}) : super(key: key);

  @override
  _SocialMediaSettingState createState() => _SocialMediaSettingState();
}

class _SocialMediaSettingState extends State<SocialMediaSetting> {
  bool enableUpdate = false;
  @override
  void initState() {
    _faceEditingController.text = Constant.facebook.toString().replaceAll("null", "").toString();
    _twitterEditingController.text = Constant.twitter.replaceAll("null", "").toString();
    _instagramEditingController.text = Constant.instagram.replaceAll("null", "").toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var updateProfile = Provider.of<MerchantAuth>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        title: Text(
          translate("navigation_bar.setting"),
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
        actions: [
          enableUpdate==false?
          IconButton(onPressed: (){
            setState(() {
              enableUpdate=!enableUpdate;
            });
          }, icon: Icon(Icons.edit),):
          IconButton(onPressed: (){
            setState(() {
              enableUpdate=!enableUpdate;
            });
          }, icon: Icon(Icons.close),),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.01),
        child: Column(
          children: [
            Text(translate("market.change_social")),
            SizedBox(height: height*0.01,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1,color: Colors.black54)
                ),
                child: TextFormField(
                  controller: _faceEditingController,
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
                      hintText: "فيس بوك"
                  ),
                  enabled: enableUpdate==false?false:true,
                )),
            SizedBox(height: height*0.01,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1,color: Colors.black54)
                ),
                child: TextFormField(
                  controller: _instagramEditingController,
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
                      hintText: "انستجرام"
                  ),
                  enabled: enableUpdate==false?false:true,
                )),
            SizedBox(height: height*0.01,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1,color: Colors.black54)
                ),
                child: TextFormField(
                  controller:  _twitterEditingController,
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
                      hintText: "تويتر"
                  ),
                  enabled: enableUpdate==false?false:true,
                )),
            SizedBox(height: height*0.01,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1,color: Colors.black54)
                ),
                child: TextFormField(
                  controller:  _whatsAppEditingController,
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
                      hintText: "رقم واتس"
                  ),
                  enabled: enableUpdate==false?false:true,
                )),
            SizedBox(height: height*0.01,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1,color: Colors.black54)
                ),
                child: TextFormField(
                  controller:  _phoneEditingController,
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
                      hintText: "رقم تواصل"
                  ),
                  enabled: enableUpdate==false?false:true,
                )),
            SizedBox(height: height*0.02,),
            Visibility(
              visible: enableUpdate==true?true:false,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: ()async{
                    if(_faceEditingController.text.toString().trim()==Constant.facebook.toString().trim()&&
                        _instagramEditingController.text.toString().trim()==Constant.instagram.toString().trim()&&
                        _twitterEditingController.text.toString().trim()==Constant.twitter.toString().trim()){
                      setState(() {
                        enableUpdate=false;
                      });
                    }else{
                      if(_faceEditingController.text.toString().trim().isNotEmpty&&
                          _twitterEditingController.text.toString().trim().isNotEmpty&&
                          _instagramEditingController.text.toString().trim().isNotEmpty
                      ){
                        await updateProfile.updateProfile(
                          context: context,
                          userName: Constant.userName.toString().trim(),
                          mobile: Constant.userPhone.toString().trim(),
                          address: Constant.userAddress.toString().trim(),
                          cityID: "${Constant.cityID}",
                          id: "${Constant.id}",
                          twitter: _twitterEditingController.text.toString().trim(),
                          face: _faceEditingController.text.toString().trim(),
                          whatsApp: _whatsAppEditingController.text.toString().trim(),
                          mobilePhone:_phoneEditingController.text.toString().trim(),
                          instagram: _instagramEditingController.text.toString().trim()
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
                    child: Text(translate("store.done"),
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold, color: colorWhite,
                          fontSize: width*0.05
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final TextEditingController _phoneEditingController = new TextEditingController();
  final TextEditingController _whatsAppEditingController = new TextEditingController();
  final TextEditingController _faceEditingController = new TextEditingController();
  final TextEditingController _twitterEditingController = new TextEditingController();
  final TextEditingController _instagramEditingController = new TextEditingController();
}
