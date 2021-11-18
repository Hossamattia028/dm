import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/merchant/market_root_pages.dart';
import 'package:dmarketing/root_pages.dart';
import 'package:dmarketing/pages/signing/root_signup.dart';
import 'package:dmarketing/pages/signing/signup_screen.dart';
import 'package:dmarketing/pages/merchant/all_order.dart';
import 'package:dmarketing/repository/market/auth_merchant.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:dmarketing/pages/signing/forget_password.dart';
import 'package:dmarketing/elements/user_input.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool pass = true;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var userAuth = Provider.of<UserAuth>(context,listen: false);
    var marketAuth = Provider.of<MerchantAuth>(context,listen: false);
    // if(Constant.userName=="market"){
    //   userAuth.cities();
    //   userAuth.regions();
    // }
    return Scaffold(
      backgroundColor: colorWhite,
      body: Container(
        height: _size.height,
        width: _size.width,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/back.png"),
        //       fit: BoxFit.cover,
        //     )
        // ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: height*0.04),
            child: Column(
              children: [
                SizedBox(
                  height: _size.height * 0.15,
                ),
                Image.asset("assets/images/logo.png",
                  width: width*0.2,height: height*0.1
                  ,fit: BoxFit.cover,
                ),

                Text(
                  translate("login.app_bar"),
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color:appColor),
                ),
                SizedBox(
                  height: _size.height * 0.06,
                ),
                Constant.userName=="consumer"?
                UserInput.userinput(hint: translate("signup.email"),
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress
                ):UserInput.userinput(hint: translate("signup.email"),
                    textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress
                ),
                SizedBox(
                  height: _size.height * 0.03,
                ),
                UserInput.userinput(
                    hint: translate("signup.password"),
                    password: pass,
                    textEditingController: _passwordController,
                    suffix: IconButton(
                      icon: Icon(
                        pass
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                    ),
                ),
                SizedBox(
                  height: _size.height * 0.03,
                ),
                ElevatedButton(
                  onPressed: () async{
                      if (_emailController.text.toString().trim().isNotEmpty&&
                          _passwordController.text.toString().trim().isNotEmpty) {
                        await userAuth.loginUser(
                            context: context,
                            password: _passwordController.text.toString().trim(),
                            email: _emailController.text.toString().trim());
                      } else {
                        showToast(translate("login.not_true"));
                      }
                  },
                  child: Text(
                    translate("login.app_bar"),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: appColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: Size(_size.width, _size.height * 0.070),
                  ),
                ),
                SizedBox(
                  height: _size.height * 0.03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      translate("login.dont_have_anaccount"),
                      style: TextStyle(
                        color: appColor.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(
                      width: width*0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            MainSignUpPage()));
                      },
                      child: Text(
                        translate("signup.signup"),
                        style: TextStyle(
                            color: appColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: appColor,
                      size: width*0.06,
                    )
                  ],
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
  bool market=true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

}
