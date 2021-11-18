import 'package:dmarketing/elements/signOut.dart';
import 'package:dmarketing/helper/ClientModel.dart';
import 'package:dmarketing/helper/Database.dart';
import 'package:dmarketing/helper/checkUser.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/main.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/about/about_us.dart';
import 'package:dmarketing/pages/about/contact_us.dart';
import 'package:dmarketing/pages/notifications.dart';
import 'package:dmarketing/pages/signing/login_screen.dart';
import 'package:dmarketing/pages/store/all_market.dart';
import 'package:dmarketing/pages/user/cart_screen.dart';
import 'package:dmarketing/pages/user/my_orders.dart';
import 'package:dmarketing/pages/user/orders.dart';
import 'package:dmarketing/root_pages.dart';
import 'package:dmarketing/repository/aboutPagesProvider.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


Widget drawerWidget(BuildContext context)  {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  var aboutProvider = Provider.of<About>(context);
return Container(
    height: height+100,
    decoration: BoxDecoration(
      color: appColor
      // gradient: LinearGradient(
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      //   stops: [-1, 0.8, 0.7, 5],
      //   colors: [
      //     appColorTwo.withOpacity(0.9),
      //     appColor.withOpacity(0.5),
      //     appColor.withOpacity(0.5),
      //     appColor.withOpacity(0.5),
      //   ],
      // ),
    ),
    padding: EdgeInsets.only(bottom: 5),
    width:width - 100,
    child: SingleChildScrollView(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height*0.2+20,
            padding: EdgeInsets.only(top: height*0.06,bottom: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(height*0.05),
                bottomRight: Radius.circular(height*0.05),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width*0.1+25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Text(Constant.userName!=null?Constant.userName.substring(0,1).toString()
                  :"H",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                      fontSize: width*0.09,color: colorWhite),),
                ),
                SizedBox(height: height*0.01,),
                Text(Constant.userName!=null?Constant.userName.toString()
                    :"الاسم",style: GoogleFonts.cairo(
                  fontSize: width*0.04,color: appColor,

                ),),
              ],
            ),
          ),
          SizedBox(height: height*0.02,),
          // Constant.id ==null?ListTile(
          //   onTap: (){
          //     Navigator.of(context).push(MaterialPageRoute(builder:
          //         (context)=> LoginScreen()));
          //   },
          //   title: Text(
          //     translate("drawer.drawer_sign_in"),
          //     style: GoogleFonts.cairo(
          //         fontWeight: FontWeight.bold,
          //         color: colorWhite,
          //         fontSize: 17
          //     ),
          //   ),
          //   leading: Icon(Icons.person,color: colorWhite,size: 30,),
          // ):SizedBox(),
          ListTile(
            title: Text(
              translate("app_bar.title"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: width*0.04
              ),
            ),
            leading: Icon(Icons.home,color: colorWhite,size: 30,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:
                  (context)=>RootPages(checkPage: "0",)));
            },
          ),
          ListTile(
            title: Text(
              translate("drawer.drawer_person_page"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Icon(Icons.person,color: colorWhite,size: 30,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:
                  (context)=>RootPages(checkPage: "3",)));
            },
          ),
          Constant.id !=null?ListTile(
            title: Text(
              translate("navigation_bar.favourite"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Icon(Icons.favorite,color: colorWhite,size: 30,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:
                  (context)=>RootPages(checkPage: "1",)));
            },
          ):SizedBox(),
          // Constant.id !=null?ListTile(
          //   title: Text(
          //     translate("navigation_bar.car_t"),
          //     style: GoogleFonts.cairo(
          //         fontWeight: FontWeight.bold,
          //         color: colorWhite,
          //         fontSize: 17
          //     ),
          //   ),
          //   leading: Icon(Icons.shopping_cart,color: colorWhite,size: 30,),
          //   onTap: (){
          //     Navigator.of(context).push(MaterialPageRoute(builder:
          //         (context)=>CartScreen()));
          //   },
          // ):SizedBox(),
          // Constant.id !=null?ListTile(
          //   title: Text(
          //     translate("navigation_bar.orde_r"),
          //     style: GoogleFonts.cairo(
          //         fontWeight: FontWeight.bold,
          //         color: colorWhite,
          //         fontSize: 17
          //     ),
          //   ),
          //   leading: Icon(Icons.storefront_outlined,color: colorWhite,size: width*0.09,),
          //   onTap: (){
          //     Navigator.of(context).push(MaterialPageRoute(builder:
          //         (context)=>UserOrdersPage()));
          //   },
          // ):SizedBox(),

          ListTile(
            title: Text(
              translate("store.sallers"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Icon(Icons.store,color: colorWhite,size: 30,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  AllMarketPage(title: translate("store.sallers"),
                 kind: "market",)));
            },
          ),
          ListTile(
            title: Text(
              translate("store.sallers_serivces"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Icon(Icons.design_services,color: colorWhite,size: 30,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  AllMarketPage(title: translate("store.sallers_serivces"),
                  kind: "service",)));
            },
          ),
          ListTile(
            title: Text(
              translate("drawer.drawer_callus"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Icon(Icons.account_box_outlined,color: colorWhite,size: 30,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  ContactUsPage()));
            },
          ),
          ListTile(
            title: Text(
              translate("drawer.drawer_us"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Text("?   ",style: GoogleFonts.cairo(fontSize: height*0.04,color: colorWhite),
              textAlign: TextAlign.center,),
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              //     AboutUsPage("${translate("drawer.drawer_us")}","about")));
            },
          ),
          ListTile(
            title: Text(
              translate("drawer.drawer_return"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Icon(Icons.wifi_protected_setup,color: colorWhite,size: 30,),
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              //     AboutUsPage("${translate("drawer.drawer_return")}","return-policy")));
            },
          ),
          ListTile(
            title: Text(
              translate("drawer.drawer_policy"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Icon(Icons.description,color: colorWhite,size: 30,),
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              //     AboutUsPage("${translate("drawer.drawer_policy")}","privacy")));
            },
          ),
          ListTile(
            title: Text(
              translate("activity_setting.change_lang"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: width*0.05
              ),
            ),
            leading: Icon(Icons.language,color: colorWhite,size: 30,),
            onTap: ()async{
              // if(Constant.lang=="ar"){
              //   Constant.lang = "en_US";
              //   await DBProvider.db.updateClient(Client(
              //     id: 0,
              //     token: Constant.token,
              //     email: Constant.email.toString(),
              //     username: Constant.userName.toString(),
              //     phone: Constant.userPhone.toString(),
              //     lang: "en_US",
              //     country: "en_US",));
              //   await checkUser();
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()));
              // }else{
              //   Constant.lang = "ar";
              //   await DBProvider.db.updateClient(Client(
              //     id: 0,
              //     lang: "ar",
              //     token: Constant.token,
              //     email: Constant.email.toString(),
              //     username: Constant.userName.toString(),
              //     phone: Constant.userPhone.toString(),
              //     country: "ar",));
              //   await checkUser();
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()));
              // }
              // Navigator.of(context).push(MaterialPageRoute(builder:
              //     (context)=>ChangeLang()));
            },
          ),
          Divider(color: colorWhite,),
          // Constant.id != null?
          Constant.id !=null?ListTile(
            title: Text(
              translate("drawer.drawer_signout"),
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: colorWhite,
                  fontSize: 17
              ),
            ),
            leading: Icon(Icons.login,color: colorWhite,size: 30,),
            onTap: (){
              showAlertDialogSignOut(context);
            },
          ):SizedBox(),
              // :SizedBox(),
          SizedBox(height: height*0.01,),
        ],
      ),
    )
);
}
