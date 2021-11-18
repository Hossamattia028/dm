import 'dart:async';

import 'package:dmarketing/pages/signing/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/user_input.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/merchant/home.dart';
import 'package:dmarketing/pages/merchant/market_root_pages.dart';
import 'package:dmarketing/root_pages.dart';
import 'package:dmarketing/pages/signing/login_screen.dart';
import 'package:dmarketing/pages/merchant/all_order.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:dmarketing/repository/market/auth_merchant.dart';

class MainSignUpPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _MainSignUpPageState();
  }
}
class _MainSignUpPageState extends State<MainSignUpPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var userAuth = Provider.of<UserAuth>(context,listen: false);
    // userAuth.cities();
    // userAuth.regions();
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: colorWhite,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/back.png"),
        //       fit: BoxFit.cover,
        //     )
        // ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              Text(
                translate("signup.signup"),
                style: TextStyle(
                    fontSize: width*0.08,
                    fontWeight: FontWeight.bold,
                    color: appColor),
              ),
              SizedBox(height: height*0.04,),
              Container(
                color:Colors.white30,
                width: width,
                height: height * 0.07,
                alignment: Alignment.center,
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child:TabBar(
                    controller: _tabController,
                    onTap: (_){},
                    tabs: [
                      SizedBox(
                        height: height*0.06,
                        width: width*0.3+10,
                        child: new Tab(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: width*0.07),
                            alignment: Alignment.center,
                            child:  Text(
                              translate("signup.market"),
                              style: GoogleFonts.cairo(
                                  fontSize: width*0.05 ,fontWeight: FontWeight.bold,color: appColor
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:height*0.06,
                        width: width*0.3+10,
                        child: new Tab(
                          child: new Container(
                            margin: EdgeInsets.symmetric(horizontal: width*0.07),
                            alignment: Alignment.center,
                            child:  Text(
                              translate("signup.app_bar"),
                              style: GoogleFonts.cairo(
                                  fontSize: width*0.05,fontWeight: FontWeight.bold,color: appColor
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                    isScrollable: true,
                    indicatorColor: appColor,
                    labelColor: appColor,

                    unselectedLabelColor:Colors.grey ,
                    unselectedLabelStyle:
                    TextStyle(color: appColor, fontSize: 18),
                    labelStyle: TextStyle(color: appColor, fontSize: 18),
                    labelPadding: EdgeInsets.only(left: 10,right: 10),
                  ),
                ),
              ),
              Container(
                height:  height * 0.8,
                width: width,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    SignUpScreen("market"),
                    SignUpScreen("user"),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


}