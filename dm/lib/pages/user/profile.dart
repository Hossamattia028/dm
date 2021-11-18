import 'package:dashed_circle/dashed_circle.dart';
import 'package:dmarketing/pages/user/favourite.dart';
import 'package:dmarketing/pages/user/setting.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:dmarketing/helper/ClientModel.dart';
import 'package:dmarketing/helper/Database.dart';
import 'package:dmarketing/helper/checkUser.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/main.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/about/contact_us.dart';
import 'package:dmarketing/pages/merchant/market_root_pages.dart';
import 'package:dmarketing/pages/merchant/market_setting.dart';
import 'package:dmarketing/pages/merchant/social_setting.dart';
import 'package:dmarketing/pages/user/cart_screen.dart';
import 'package:dmarketing/pages/user/my_orders.dart';
import 'package:dmarketing/pages/user/orders.dart';
import 'package:dmarketing/root_pages.dart';
import 'package:dmarketing/pages/user/user_setting.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:dmarketing/elements/PermissionDeniedWidget.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/elements/signOut.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:dashed_circle/dashed_circle.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var userAuth = Provider.of<UserAuth>(context);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        title: Text(
          translate("profile.profile"),
          style: GoogleFonts.cairo(
              color: colorDark,fontWeight: FontWeight.bold
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  FavouritePage()));
            },
            child: Image.asset(
              "assets/icons/hartyB.png",
              width: width * 0.07,
              height: height * 0.03,
            ),
          ),
          SizedBox(width: width*0.03,),
          GestureDetector(
            onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (context)=>CartScreen()));
            },
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Align(
                  alignment: Alignment.lerp(Alignment.topRight,
                      Alignment.centerRight,0.5),
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: appColorTwo,
                    ),
                  ),
                ),
                Icon(Icons.shopping_cart_outlined,color: appColor,),
              ],
            ),
          ),
          SizedBox(width: width*0.03,),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:
                  (context)=>SettingPage()));
            },
            child: Image.asset("assets/icons/settings.png",
              height: height*0.03,width: width*0.06,),
          ),
          SizedBox(width: width*0.03,),
        ],
      ),
      body:
      // Constant.id != null?
      Container(
        height: height*0.7+20,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                DashedCircle(
                  child: Padding(padding: EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage("assets/images/girl.jpg"),
                    ),
                  ),
                  color: Colors.grey,
                ),
                SizedBox(height: height*0.03,),
                Text(
                  "${Constant.userName}",
                  style: GoogleFonts.cairo(
                      color: colorDark,fontWeight: FontWeight.bold
                  ),
                ),
                Text("1200 ${translate("store.dollar")}",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: width*0.04+3),
                ),
                SizedBox(height: height*0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    smallWidget(width: width,height: height,content: "Deliverd Order",imgPath:"trueA.png"),
                    smallWidget(width: width,height: height,content: "Deliverd Order",imgPath:"boxA.png"),
                    smallWidget(width: width,height: height,content: "Deliverd Order",imgPath:"carMA.png"),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Align(
                  alignment: Constant.lang=="ar"?
                  Alignment.centerRight:Alignment.centerLeft,
                  child: Text("    "+translate("profile.profile_details")+"    ",
                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                        color: Colors.black54),),
                ),
                SizedBox(
                  height: height*0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    smallWidget(width: width,height: height,content: "25 gift",imgPath:"giftC.png"),
                    smallWidget(width: width,height: height,content: "50 coins",imgPath:"dC.png"),
                  ],
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    smallWidget(width: width,height: height,content: "100 like",imgPath:"hartyC.png"),
                    smallWidget(width: width,height: height,content: "25 comment",imgPath:"cahtC.png"),
                    smallWidget(width: width,height: height,content: "50 friend",imgPath:"frinedC.png"),
                  ],
                ),
                SizedBox(
                  height: height*0.01,
                ),
                Align(
                  alignment: Constant.lang=="ar"?
                  Alignment.centerRight:Alignment.centerLeft,
                  child: Text("    "+translate("profile.packages")+"    ",
                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                        color: Colors.black54),),
                ),
                Image.asset("assets/icons/all_options.png",
                  width: width*0.8,height: height*0.2+20,fit: BoxFit.fill,),
                SizedBox(
                  height: height*0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    smallCoinsWidget(color: colorSliver.withOpacity(0.3),
                    mainColor: colorSliver,
                    kind: "sliver",
                    imgPath: "silver.png",
                    title: translate("packages.sliver"),
                    width: width,height: height),
                    smallCoinsWidget(color: colorGold.withOpacity(0.3),
                        mainColor: colorGold,
                        kind: "gold",
                        imgPath: "gold.png",
                        title: translate("packages.gold"),
                        width: width,height: height),
                    smallCoinsWidget(color: colorBronze.withOpacity(0.3),
                        mainColor: colorBronze,
                        kind: "bronze",
                        imgPath: "bronze.png",
                        title: translate("packages.Bronze"),
                        width: width,height: height),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Align(
                  alignment: Constant.lang=="ar"?
                  Alignment.centerRight:Alignment.centerLeft,
                  child: Text("    "+translate("profile.dashboard")+"    ",
                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                        color: Colors.black54),),
                ),
                SizedBox(height: height*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    smallWidget(width: width,height: height,content: translate("profile."),imgPath:"option_product.png"),
                    smallWidget(width: width,height: height,content: translate("profile."),imgPath:"option_story.png"),
                    smallWidget(width: width,height: height,content: "friend",imgPath:"seals.png"),
                  ],
                ),
                SizedBox(height: height*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    smallWidget(width: width,height: height,content: translate("profile.add_product")
                        ,imgPath:"add_productA-1.png"),
                    smallWidget(width: width,height: height,content: translate("profile.add_story"),imgPath:"add_story.png"),
                    smallWidget(width: width,height: height,content: translate("profile.set_help"),imgPath:"set_help.png"),
                  ],
                ),
                SizedBox(height: height*0.02,),

              ],
            )
        ),
      )
          // :PermissionDeniedWidget(),
    );
  }
  Widget smallWidget({String content,String imgPath,double width,double height}){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Image.asset("assets/icons/$imgPath",
          height: height*0.06,width: width*0.1+20,fit: BoxFit.contain,),
          SizedBox(height: height*0.01,),
          SizedBox(
            width: width*0.3,
            child: Text("$content",
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                  fontSize: width*0.04),textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget smallCoinsWidget({double width,double height,String title,
    String imgPath, String kind,Color color,Color mainColor}){
    return Container(
      color: color,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$title",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
              color: colorDark,fontSize: width*0.03+3),),
          Text("12 Products"),
          Text("30 Coins"),
          Text("2 Gift"),

          Image.asset("assets/icons/$imgPath",
            fit: BoxFit.contain,width: width*0.1+2,height: height*0.04,),

          SizedBox(height: height*0.02,),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: height*0.01-5,
                  horizontal: width*0.04),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:mainColor
              ),
              child: Text(translate("packages.buy")),
            ),
          ),
          SizedBox(height: height*0.01,),

        ],
      ),
    );
  }
}

