import 'package:dmarketing/elements/PermissionDeniedWidget.dart';
import 'package:dmarketing/elements/drawer.dart';
import 'package:dmarketing/elements/drawer.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/connection_part/all_status.dart';
import 'package:dmarketing/pages/connection_part/chat_main.dart';
import 'package:dmarketing/pages/connection_part/home_chat_list.dart';
import 'package:dmarketing/pages/connection_part/posts_page.dart';
import 'package:dmarketing/pages/store/home.dart';
import 'package:dmarketing/pages/user/profile.dart';
import 'package:dmarketing/pages/user/set_help.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RootPages extends StatefulWidget {
  String checkPage;
  RootPages({this.checkPage});
  @override
  _RootPagesState createState() => _RootPagesState();
}

class _RootPagesState extends State<RootPages> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final pages = [
    SetHelpPage(),
    AllStatusPages(),
    MainChatPage(),
    StoreHomePage(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    if (widget.checkPage != null) {
      selectedIndex = int.parse(widget.checkPage.toString()).toInt();
    } else {
      selectedIndex = 0;
    }
    super.initState();
  }

  var userInfo;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var userProfile = Provider.of<UserAuth>(context,listen: false);
    if(Constant.id==null||Constant.id=="null"||Constant.id==""){
      userProfile.userProfile("${Constant.id}");
    }
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body:  Stack(
        children: [
          pages[selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: bottomNavigationBar(width,height),
          ),
        ],
      ),
    );
  }

  TextEditingController _searchEditingController = new TextEditingController();

  Widget bottomNavigationBar(double width, double height) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            color: colorWhite,
            height: height * 0.1+13,
            width: width,
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * 0.1),
                topRight: Radius.circular(width * 0.1),
              ),
              child: BottomNavigationBar(
                unselectedItemColor: appColor,
                showSelectedLabels: true,
                currentIndex: selectedIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (ind) {
                  setState(() {
                    selectedIndex = ind;
                  });
                },
                unselectedLabelStyle: GoogleFonts.cairo(
                  color: colorDark,
                  fontWeight: FontWeight.bold,
                ),
                selectedLabelStyle: GoogleFonts.cairo(
                  color: colorDark,
                  fontWeight: FontWeight.bold,
                ),
                fixedColor: colorDark,
                backgroundColor: colorWhite,
                items: [
                  BottomNavigationBarItem(
                    // label: translate("navigation_bar.account"),
                    icon: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/help.png",
                            height: height * 0.04+2,
                            width: width * 0.1+10,
                            fit: BoxFit.contain,
                          ),
                          Divider(thickness: selectedIndex == 0 ? 2 : 0,
                            color:selectedIndex == 0 ? appColor:Colors.transparent
                            ,indent: 10,endIndent: 10,),
                        ],
                      ),
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    // label: translate("navigation_bar.account"),
                    icon: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/story.png",
                            height: height * 0.04-2,
                            width: width * 0.1+5,
                            fit: BoxFit.contain,
                          ),
                          Divider(thickness: selectedIndex == 1 ? 2 : 0,
                            color:selectedIndex == 1 ? appColor:Colors.transparent
                            ,indent: 10,endIndent: 10,),
                        ],
                      ),
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Container(),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    // label: translate("navigation_bar.account"),
                    icon: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/shop.png",
                            height: height * 0.04,
                            width: width * 0.1,
                            fit: BoxFit.contain,
                          ),
                          Divider(thickness: selectedIndex == 3 ? 2 : 0,
                            color:selectedIndex == 3 ? appColor:Colors.transparent
                            ,indent: 10,endIndent: 10,),
                        ],
                      ),
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    // label: translate("navigation_bar.account"),
                    icon: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/profile.png",
                            height: height * 0.04-3,
                            width: width * 0.1,
                            fit: BoxFit.contain,
                          ),
                          Divider(thickness: selectedIndex == 4 ? 2 : 0,
                            color:selectedIndex ==4? appColor:Colors.transparent
                            ,indent: 10,endIndent: 10,),
                        ],
                      ),
                    ),
                    label: "",
                  ),
                ],
              ),
            )),
        Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
            },
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.03),
                  padding: EdgeInsets.only(
                      left: width * 0.03,
                      right: width * 0.03,
                      top: width * 0.01,
                      bottom: width * 0.09),
                  child:  Image.asset(
                    "assets/images/logo.png",
                    alignment: Alignment.center,
                    height: height*0.08,
                    fit: BoxFit.cover,
                  ),),
                Divider(thickness: selectedIndex == 2 ? 1 : 0,
                  color:selectedIndex ==2? appColor:Colors.transparent
                  ,indent: width*0.4,endIndent: width*0.4,),
              ],
            )
          ),
        ),
      ],
    );
  }
}
