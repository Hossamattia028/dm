import 'dart:async';

import 'package:dmarketing/repository/store/categories.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/drawer.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/merchant/all_market_products.dart';
import 'package:dmarketing/pages/merchant/all_order.dart';
import 'package:dmarketing/pages/merchant/market_root_pages.dart';
import 'package:dmarketing/repository/market/auth_merchant.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:dmarketing/repository/market/market_categories.dart';
import 'package:dmarketing/repository/market/market_order.dart';

class MarketHomePage extends StatefulWidget {
  const MarketHomePage({Key key}) : super(key: key);

  @override
  _MarketHomePageState createState() => _MarketHomePageState();
}

class _MarketHomePageState extends State<MarketHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Timer(Duration(seconds: 2),(){setState(() {});});
    Timer(Duration(seconds: 5),(){setState(() {});});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var marketProfile = Provider.of<MerchantAuth>(context);
    var userAuth = Provider.of<UserAuth>(context);
    var catProvider = Provider.of<CategoriesProvider>(context);
    var catMarketProvider = Provider.of<MarketCategoriesProvider>(context);
    var orderProvider = Provider.of<MarketOrder>(context);
    userAuth.cities();
    if(Constant.id!=null&&Constant.kind=="market"){
      marketProfile.dataMarketProfile();
      catProvider.getCategories(asMarket: true);
      catProvider.getSubCategories("2");
      if(orderProvider.orderLength==null){
        marketProfile.dataMarketProfile().then((value) {
          print("userID: "+value.toString());
          catMarketProvider.getMarketProducts("$value");
        });
        orderProvider.getOrders();
      }
    }else if(Constant.id!=null&&Constant.kind=="service"){
      marketProfile.dataServiceProfile();
    }
    return Scaffold(
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: width*0.06,right: width*0.06,
        top: height*0.04,bottom:height*0.02 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mainWidget(width, height, "assets/images/customer.png", "عدد العملاء", "0", "k"),
                SizedBox(width: width*0.08,),
                Constant.kind =="market"?
                mainWidget(width, height, "assets/images/order.png", "عدد الطلبات", "${orderProvider.orderLength}", "order"):
                mainWidget(width, height, "assets/images/eye.png", "المشاهدات", "${orderProvider.orderLength}", "order"),
              ],
            ),
            SizedBox(height: height*0.06,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Constant.kind =="market"?
                mainWidget(width, height, "assets/images/3d-design.png", "المنتجات", "${catMarketProvider.productsLength}", "product"):
                mainWidget(width, height, "assets/images/star.png", "التقييمات", "${orderProvider.orderLength}", "order"),
                SizedBox(width: width*0.08,),
                mainWidget(width, height, "assets/images/Icon ionic-md-chatbubbles.png", "عدد المراسلات", "0", "message"),
              ],
            ),
          ],
        ),
      ),
    );
  }
  int selectedIndex = 0;
  Widget mainWidget(double width,double height,String imgPath,
      String title,String count,String kind){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            if(Constant.kind=="market"){
              if(kind=="order"){
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (context)=> AllOrdersPage()));
              }else if(kind=="product"){
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (context)=> AllMarketProducts()));
              }else if(kind=="message"){
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (context)=> MarketRootPages(checkPage: "3",)));
              }
            }
          },
          child: Container(
            padding: EdgeInsets.all(width * 0.03),
            width: width * 0.3+20,
            height: height * 0.2 - 20,
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(width * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
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
                    "${count.toString().trim()=="null"?"0":
                    count.toString().trim().replaceAll("null", "").toString()}",
                    style: TextStyle(color: colorDark),
                  ),
                ),
                SizedBox(height: height*0.01),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("$imgPath",
                    width: width*0.2,height:imgPath.toString()=="assets/images/Iconchat.png"?
                    height*0.05: height*0.06,
                    fit: BoxFit.contain,alignment: Alignment.center,),
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
