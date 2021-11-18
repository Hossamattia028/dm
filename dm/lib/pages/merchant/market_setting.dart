import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/repository/market/auth_merchant.dart';

class MarketSettingPage extends StatefulWidget {
  const MarketSettingPage({Key key}) : super(key: key);

  @override
  _MarketSettingPageState createState() => _MarketSettingPageState();
}

class _MarketSettingPageState extends State<MarketSettingPage> {
  bool enableUpdate = false;
  @override
  void initState() {
    _nameEditingController.text = Constant.userName;
    _mobileEditingController.text = Constant.userPhone;
    _locationEditingController.text = Constant.userAddress;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var updateProfile = Provider.of<MerchantAuth>(context);
    return Scaffold(
      backgroundColor: colorWhite,
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
            // SizedBox(height: height*0.02,),
            // Text(translate("market.change_email")),
            // SizedBox(height: height*0.01,),
            // Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(12),
            //         border: Border.all(width: 1,color: Colors.black54)
            //     ),
            //     child: TextFormField(
            //       controller: _emailEditingController,
            //       textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
            //       decoration: InputDecoration(
            //         hintStyle: TextStyle(
            //           color: Colors.grey,
            //         ),
            //         contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            //         border: InputBorder.none,
            //         focusedBorder: InputBorder.none,
            //         enabledBorder: InputBorder.none,
            //         disabledBorder: InputBorder.none,
            //       ),
            //     )),
            SizedBox(height: height*0.02,),

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
                  width: width*0.6,
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
                        _mobileEditingController.text.toString().trim()==Constant.userPhone.toString().trim()&&
                        _locationEditingController.text.toString().trim()==Constant.userAddress.toString().trim()){
                      setState(() {
                        enableUpdate=false;
                      });
                    }else{
                      if(_nameEditingController.text.toString().trim().isNotEmpty&&
                          _mobileEditingController.text.toString().trim().isNotEmpty
                      ){
                        await updateProfile.updateProfile(
                            context: context,
                            userName: _nameEditingController.text.toString().trim(),
                            mobile: _mobileEditingController.text.toString().trim(),
                            address: _locationEditingController.text.toString().trim(),
                            cityID: "${Constant.cityID}",
                            id: "${Constant.id}",
                            face:"${Constant.facebook}",
                            instagram: "${Constant.instagram}",
                            twitter: "${Constant.twitter}",
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
  final TextEditingController _nameEditingController = new TextEditingController();
  final TextEditingController _mobileEditingController = new TextEditingController();
  // final TextEditingController _emailEditingController = new TextEditingController();

  final TextEditingController _locationEditingController = new TextEditingController();
}
