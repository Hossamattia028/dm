import 'package:dmarketing/pages/merchant/add_product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/PermissionDeniedWidget.dart';
import 'package:dmarketing/elements/drawer.dart';
import 'package:dmarketing/helper/checkUser.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/merchant/customer_chat_list.dart';
import 'package:dmarketing/pages/merchant/home.dart';
import 'package:dmarketing/pages/user/profile.dart';
import 'package:dmarketing/repository/market/auth_merchant.dart';
import 'package:dmarketing/repository/market/market_categories.dart';
import 'package:dmarketing/repository/market/market_order.dart';

class MarketRootPages extends StatefulWidget {
  String checkPage;
  MarketRootPages({this.checkPage});

  @override
  _MarketRootPagesState createState() => _MarketRootPagesState();
}

class _MarketRootPagesState extends State<MarketRootPages> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final pages = [
    MarketHomePage(),
    MarketHomePage(),
    AddProductPage(),
    CustomerChatList(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    if(widget.checkPage!=null){
      selectedIndex = int.parse(widget.checkPage.toString()).toInt();
    }else{
      selectedIndex = 0;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        child: Container(
          height: height * 0.3-20,
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
            padding: EdgeInsets.only(
                top: height * 0.02,
                right: width * 0.04,
                left: width * 0.04,
                bottom: height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: colorWhite,
                      size: width * 0.08,
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.1 + 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            Constant.userName!=null?Constant.userName.substring(0,1).toString():
                            "H",
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.09,
                                color: appColor),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          Constant.userName!=null?Constant.userName:"سلسلة محلات",
                          style: GoogleFonts.cairo(
                              color: colorWhite, fontWeight: FontWeight.bold),
                        ),
                        // Text(
                        //   Constant.userPhone!=null?Constant.userPhone:"",
                        //   style: GoogleFonts.cairo(
                        //       color: colorWhite, fontWeight: FontWeight.bold),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: new BoxDecoration(
            color: appColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(height * 0.08),
              bottomLeft: Radius.circular(height * 0.08),
            ),
          ),
        ),
        preferredSize: new Size(width, height * 0.2-15),
      ),
      body: Stack(
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

  Widget bottomNavigationBar(double width,double height) {
    if(Constant.kind=="market"){
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              height: height*0.1,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(width*0.1),
                  topRight: Radius.circular(width*0.1),),
                color: colorWhite,
                boxShadow: [
                  BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width*0.1),
                  topRight: Radius.circular(width*0.1),
                ),
                child: BottomNavigationBar(
                  currentIndex: selectedIndex,
                  fixedColor: colorWhite,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedFontSize: 0.0,
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
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        selectedIndex == 0
                            ? "assets/images/Home.png"
                            : "assets/images/home.png",
                        height: height * 0.04,
                        width: width * 0.1,
                        fit: BoxFit.contain,
                      ),
                      // label: translate("navigation_bar.discover"),
                      label: "",
                    ),
                    Constant.kind!="market"?
                    BottomNavigationBarItem(
                      // label: translate("navigation_bar.favourite"),
                      label: "",
                      icon: Image.asset(
                        selectedIndex == 1
                            ? "assets/images/Icon material-dashboard.png"
                            : "assets/images/Icon material-dashboard.png",
                        height: height * 0.04,
                        width: width * 0.1,
                        fit: BoxFit.contain,
                      ),
                    ):
                    BottomNavigationBarItem(
                      // label: translate("navigation_bar.favourite"),
                      label: "",
                      icon: Image.asset(
                        selectedIndex == 1
                            ? "assets/images/Fav.png"
                            : "assets/images/fav.png",
                        height: height * 0.04,
                        width: width * 0.1,
                        fit: BoxFit.contain,
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon:Container(
                        decoration: BoxDecoration(
                            border:selectedIndex==2? Border(bottom: BorderSide(width: 4,
                                color: appColor)):Border()
                        ),
                        child: Container(
                          height: height*0.05-2,
                          width: width*0.2,
                        ),
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat,size: selectedIndex == 3?width*0.1+2:
                      width*0.09,color:selectedIndex == 3?appColor:Colors.grey,),
                      // label: translate("navigation_bar.cart"),
                      label: "",
                    ),
                    // icon:  Image.asset(
                    //   selectedIndex==1?"assets/images/Iconchat.png":
                    //   "assets/images/Iconchat.png",height: height*0.04,
                    //   width: width*0.1,
                    //   fit: BoxFit.contain,),
                    BottomNavigationBarItem(
                      // label: translate("navigation_bar.account"),
                      icon: Image.asset(
                        selectedIndex == 4
                            ? "assets/images/Profile.png"
                            : "assets/images/profile.png",
                        height: height * 0.04,
                        width: width * 0.1,
                        fit: BoxFit.contain,
                      ),
                      label: "",
                    ),
                  ],
                ),
              )
          ),
          if(Constant.kind=="market") Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex = 2;
                });
              },
              child: Container(
                  margin: EdgeInsets.only(bottom: height*0.07),
                  padding: EdgeInsets.only(left: width*0.03,right: width*0.03,top: width*0.01,
                      bottom: width*0.01),
                  decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(100)),
                  child:Icon(Icons.add,color: colorWhite,size: width*0.1,)
              ),
            ),
          ),
        ],
      );
    }else{
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              height: height*0.1,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(width*0.1),
                  topRight: Radius.circular(width*0.1),),
                color: colorWhite,
                boxShadow: [
                  BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width*0.1),
                  topRight: Radius.circular(width*0.1),
                ),
                child: BottomNavigationBar(
                  currentIndex: selectedIndex,
                  fixedColor: colorWhite,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedFontSize: 0.0,
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
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        selectedIndex == 0
                            ? "assets/images/Home.png"
                            : "assets/images/home.png",
                        height: height * 0.04,
                        width: width * 0.1,
                        fit: BoxFit.contain,
                      ),
                      // label: translate("navigation_bar.discover"),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      // label: translate("navigation_bar.favourite"),
                      label: "",
                      icon: Image.asset(
                        selectedIndex == 1
                            ? "assets/images/Icon material-dashboard.png"
                            : "assets/images/Icon material-dashboard.png",
                        height: height * 0.04,
                        width: width * 0.1,
                        fit: BoxFit.contain,
                      ),
                    ),

                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat,size: selectedIndex == 3?width*0.1+2:
                      width*0.09,color:Colors.grey,),
                      // label: translate("navigation_bar.cart"),
                      label: "",
                    ),
                    // icon:  Image.asset(
                    //   selectedIndex==1?"assets/images/Iconchat.png":
                    //   "assets/images/Iconchat.png",height: height*0.04,
                    //   width: width*0.1,
                    //   fit: BoxFit.contain,),
                    BottomNavigationBarItem(
                      // label: translate("navigation_bar.account"),
                      icon: Image.asset(
                        selectedIndex == 4
                            ? "assets/images/Profile.png"
                            : "assets/images/profile.png",
                        height: height * 0.04,
                        width: width * 0.1,
                        fit: BoxFit.contain,
                      ),
                      label: "",
                    ),
                  ],
                ),
              )
          ),
        ],
      );
    }

  }

  int selectedIndex = 0;
  Widget mainWidget(double width,double height,String imgPath,
      String title,String count,String kind){
    return Column(
      children: [
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(width * 0.03),
            width: width * 0.4,
            height: height * 0.2 - 16,
            decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: width * 0.01),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                  child: Text(
                    "$count",
                    style: TextStyle(color: colorDark),
                  ),
                ),
                SizedBox(height: height*0.01),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("$imgPath",
                    width: width*0.2,height: height*0.09,
                    fit: BoxFit.cover,),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height*0.01),
        Text("$title",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
            color: Colors.black54,fontSize: width*0.04+2),)
      ],
    );
  }
}
