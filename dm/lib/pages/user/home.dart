import 'dart:async';
import 'dart:convert';
import 'package:dmarketing/models/profile/selller.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dmarketing/elements/homeCard.dart';
import 'package:dmarketing/elements/review.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/sliderModel.dart';
import 'package:dmarketing/pages/signing/login_screen.dart';
import 'package:dmarketing/pages/store/all_market.dart';
import 'package:dmarketing/pages/store/market_info.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}
class _Home extends State<Home>  with TickerProviderStateMixin{
  SwiperController _swiperController;
  TabController _tabController,_tabController_belwo;
  @override
  void initState() {
    _swiperController = SwiperController();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController_belwo = new TabController(vsync: this, length: 2);
    colorWomen=appColor;
    colorBelowMarket=appColor;
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var categoryProvider = Provider.of<CategoriesProvider>(context,listen: false);
    var cartUser = Provider.of<FavAndCart>(context);
    var userProfile = Provider.of<UserAuth>(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorWhite,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 2, right: 2,top: 2),
          child: Column(
            children: [
              Container(
                height: height * 0.2+10,
                width: width,
                child: FutureBuilder(
                    future: categoryProvider.getSlider(),
                    builder:
                        (context, AsyncSnapshot<List<SliderModel>> snapshots) {
                      if (snapshots.data == null) {
                        return Container(
                          width: width,
                          height: height * 0.2,
                          child: Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.cover,
                          ),
                        );
                      } else if (snapshots.hasData){
                        return Swiper(
                          controller: _swiperController,
                          autoplay: true,
                          autoplayDisableOnInteraction: false,
                          itemBuilder: (BuildContext context, int index) {
                            return  SizedBox(
                              height: height * 0.2+20,
                              width: width,
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                imageUrl:
                                "${snapshots.data[index].image}",
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/loading.gif',
                                  fit: BoxFit.contain,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            );
                          },
                          itemCount: snapshots.data.length,
                          pagination:
                          new SwiperPagination(alignment: Alignment.bottomCenter,),
                          control: new SwiperControl(
                            color: appColor,
                          ),
                          physics: BouncingScrollPhysics(),
                        );
                      }else{
                        return Container(
                          width: width,
                          height: height * 0.2,
                          child: Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }),
              ),
              Container(
                color: colorWhite,
                width: width,
                height: height * 0.04,
                alignment: Alignment.center,
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 1,
                  child:TabBar(
                    controller: _tabController,
                    onTap: _onTap(),
                    tabs: [
                      SizedBox(
                        child: new Tab(
                          child: new Container(
                            alignment: Alignment.center,
                            width: width*0.5,
                            child: Text(
                              translate("store.sallers"),
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold,color: colorWomen
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: new Tab(
                          child: new Container(
                            alignment: Alignment.center,
                            width: width*0.5,
                            child: Text(
                              translate("store.sallers_serivces"),
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold,color: colorMan
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                    indicatorColor: colorWhite,
                    labelColor: colorWhite,
                    indicator: new BoxDecoration(
                      color: colorWhite,
                      border: Border(bottom: BorderSide(color: appColor,width: 2)),
                    ),
                    unselectedLabelColor:Colors.grey ,
                    unselectedLabelStyle:
                    TextStyle(color: colorWhite, fontSize: 18),
                    labelStyle: TextStyle(color: colorWhite, fontSize: 18),
                    labelPadding: EdgeInsets.only(left: 10,right: 10),
                  ),
                ),
              ),
              SizedBox(height: height*0.01,),
              Container(
                height:  height * 0.3,
                width: width,
                color: colorWhite,
                alignment: Alignment.center,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    CardHome("market",'', "assets/images/subtraction.png"),
                    CardHome("service",'', "assets/images/suit.png"),
                  ],
                ),
              ),
              Container(
                color: colorWhite,
                width: width,
                height: height * 0.04,
                alignment: Alignment.center,
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 1,
                  child:TabBar(
                    controller: _tabController_belwo,
                    onTap: _onTapBelow(),
                    tabs: [
                      SizedBox(
                        child: new Tab(
                          child: new Container(
                            alignment: Alignment.center,
                            width: width*0.5,
                            child: Text(
                              translate("store.sallers"),
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold,color: colorBelowMarket
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: new Tab(
                          child: new Container(
                            alignment: Alignment.center,
                            width: width*0.5,
                            child: Text(
                              translate("store.sallers_serivces"),
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold,color: colorBelowService
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                    indicatorColor: colorWhite,
                    labelColor: colorWhite,
                    indicator: new BoxDecoration(
                      color: colorWhite,
                      border: Border(bottom: BorderSide(color: appColor,width: 2)),
                    ),
                    unselectedLabelColor:Colors.grey ,
                    unselectedLabelStyle:
                    TextStyle(color: colorWhite, fontSize: 18),
                    labelStyle: TextStyle(color: colorWhite, fontSize: 18),
                    labelPadding: EdgeInsets.only(left: 10,right: 10),
                  ),
                ),
              ),
              Container(
                height:  height * 0.4-20,
                width: width,
                color: colorWhite,
                alignment: Alignment.center,
                child: TabBarView(
                  controller: _tabController_belwo,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: height*0.3-10,
                          width: width,
                          child: FutureBuilder(
                            future: categoryProvider.getSellers(),
                            builder: (context,AsyncSnapshot<List<SellerModel>> snapshot) {
                              if (snapshot.data == null) {
                                return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
                              } else {
                                return  snapshot.data.length==0?
                                Center(child:Text(translate("store.no_market",),
                                  style: TextStyle(color: appColor),)):
                                ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder:
                                              (context)=>MarketInfoPage(kind: "market",
                                            id: "${snapshot.data[index].id}",
                                            name: "${snapshot.data[index].name}",
                                            image: "${snapshot.data[index].image}",
                                            address: "${snapshot.data[index].address}",
                                            phone: "${snapshot.data[index].mobilePhone}",
                                          )));
                                        },
                                        child: Container(
                                          width: width,
                                          height: height*0.1+20,
                                          padding: EdgeInsets.symmetric(horizontal: width*0.04,
                                              vertical: height*0.01),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: appColorTwo.withOpacity(0.2)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: height*0.06,
                                                    width: width*0.1+10,
                                                    margin: EdgeInsets.only(top: height*0.02),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: snapshot.data[index].image==""||snapshot.data[index].image==null?
                                                        AssetImage("assets/images/Vatrinty Logo.jpg"):
                                                        NetworkImage("${snapshot.data[index].image}"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius: BorderRadius.circular(50),
                                                      border: Border.all(width: 1),
                                                    ),
                                                  ),
                                                  SizedBox(width: width*0.05,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width*0.4+20,
                                                        child: Text("${snapshot.data[index].name}",
                                                          style: GoogleFonts.cairo(color: Colors.black54,
                                                              fontWeight: FontWeight.bold,fontSize: width*0.04),overflow: TextOverflow.ellipsis,),
                                                      ),
                                                      Text(" 35 "+translate("store.product"),
                                                        style: GoogleFonts.cairo(color: appColor,
                                                            fontSize: width*0.04),),
                                                      reView(140),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.location_pin,color: appColor,
                                                        size: width*0.05,),
                                                      Container(
                                                        width: width*0.1,
                                                        height: height*0.03,
                                                        child: Text("${snapshot.data[index].address}",
                                                          style: GoogleFonts.cairo(
                                                            color: Colors.grey,
                                                          ),overflow: TextOverflow.ellipsis,),
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      if(Constant.token!=null){
                                                        customLaunch("tel:${snapshot.data[index].mobilePhone}");
                                                      }else{
                                                        Navigator.of(context).push(MaterialPageRoute(builder:
                                                            (context)=> LoginScreen()));
                                                      }
                                                    },
                                                    child: Container(
                                                      width: width*0.2,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),
                                                        color: appColor,
                                                      ),
                                                      padding: EdgeInsets.only(right: 12,left: 12,top: 5,bottom: 5),
                                                      child: Text(translate("store.contact"),
                                                        style: GoogleFonts.cairo(color: colorWhite,
                                                            fontWeight: FontWeight.bold),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: height*0.02,);
                                    },
                                    itemCount: 2);
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,right: width*0.02),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                  AllMarketPage(title: translate("store.sallers"),
                                    kind: "market",)));
                            },
                            child: Text(
                              translate("home.show_all"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color:appColor),
                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     GestureDetector(
                        //       child: Container(
                        //           height: height*0.05,
                        //           alignment: Alignment.center,
                        //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
                        //           ),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(20),
                        //             color: appColorTwo,
                        //             border: Border.all(width: 1,color: Colors.grey),
                        //           ),
                        //           child: Text("طبية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                        //               color: colorWhite),)
                        //       ),
                        //     ),
                        //     GestureDetector(
                        //       child: Container(
                        //           height: height*0.05,
                        //           alignment: Alignment.center,
                        //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
                        //           ),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(20),
                        //             color: colorWhite,
                        //             border: Border.all(width: 1,color: Colors.grey),
                        //           ),
                        //           child: Text("تعليمية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                        //               color: appColor),)
                        //       ),
                        //     ),
                        //     GestureDetector(
                        //       child: Container(
                        //           height: height*0.05,
                        //           alignment: Alignment.center,
                        //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
                        //           ),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(20),
                        //             color: colorWhite,
                        //             border: Border.all(width: 1,color: Colors.grey),
                        //           ),
                        //           child: Text("هندسية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                        //               color: appColor),)
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: height*0.01,),
                        Container(
                          height: height*0.3,
                          width: width,
                          child: FutureBuilder(
                            future: categoryProvider.getSellersServices(),
                            builder: (context,AsyncSnapshot<List<SellerModel>> snapshot) {
                              if (snapshot.data == null) {
                                return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
                              } else {
                                return  snapshot.data.length==0?
                                Center(child:Text(translate("store.no_service",),
                                  style: TextStyle(color: appColor),)):
                                ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder:
                                              (context)=>MarketInfoPage(kind: "service",
                                            id: "${snapshot.data[index].id}",
                                            name: "${snapshot.data[index].name}",
                                            image: "${snapshot.data[index].image}",
                                            address: "${snapshot.data[index].address.replaceAll("null", "").toString()}",
                                            phone: "${snapshot.data[index].mobilePhone}",
                                            desc: "${snapshot.data[index].desc}",
                                            jobTitle: "${snapshot.data[index].jobTitle}",
                                          )));
                                        },
                                        child: Container(
                                          width: width,
                                          height: height*0.1+20,
                                          padding: EdgeInsets.symmetric(horizontal: width*0.04,
                                              vertical: height*0.01),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: appColorTwo.withOpacity(0.2)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: height*0.06,
                                                    width: width*0.1+10,
                                                    margin: EdgeInsets.only(top: height*0.02),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage("${snapshot.data[index].image}"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius: BorderRadius.circular(50),
                                                      border: Border.all(width: 1),
                                                    ),
                                                  ),
                                                  SizedBox(width: width*0.05,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${snapshot.data[index].name}",
                                                        style: GoogleFonts.cairo(color: Colors.black54,
                                                            fontWeight: FontWeight.bold,fontSize: width*0.05),),
                                                      Text("${snapshot.data[index].jobTitle}",
                                                        style: GoogleFonts.cairo(color: appColor,
                                                            fontSize: width*0.04),),
                                                      reView(140),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.location_pin,color: appColor,
                                                        size: width*0.05,),
                                                      Text(snapshot.data[index].address.toString()=="null"?"الموقع"
                                                          :"${snapshot.data[index].address}",style: GoogleFonts.cairo(
                                                        color: Colors.grey,
                                                      ),),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      if(Constant.token!=null){
                                                        customLaunch("tel:${snapshot.data[index].mobilePhone}");
                                                      }else{
                                                        Navigator.of(context).push(MaterialPageRoute(builder:
                                                            (context)=> LoginScreen()));
                                                      }
                                                    },
                                                    child: Container(
                                                      width: width*0.2,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),
                                                        color: appColor,
                                                      ),
                                                      padding: EdgeInsets.only(right: 12,left: 12,top: 5,bottom: 5),
                                                      child: Text(translate("store.contact"),
                                                        style: GoogleFonts.cairo(color: colorWhite,
                                                            fontWeight: FontWeight.bold),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: height*0.02,);
                                    },
                                    itemCount: 2);
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,right: width*0.02),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                  AllMarketPage(title: translate("store.sallers_serivces"),
                                    kind: "service",)));
                            },
                            child: Text(
                              translate("home.show_all"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color:appColor),
                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
  Color colorWomen= Colors.grey;
  Color colorMan= Colors.grey;
  Color colorBelowMarket= Colors.grey;
  Color colorBelowService= Colors.grey;
  _onTap(){
    _tabController.addListener(() {
      setState(() {
        switch(_tabController.index){
          case 0:
            colorMan=Colors.grey;
            colorWomen=appColor;
            break;
          case 1 :
            colorWomen=Colors.grey;
            colorMan=appColor;
            break;
        }
      });
    });
  }
  _onTapBelow(){
    _tabController_belwo.addListener(() {
      setState(() {
        switch(_tabController_belwo.index){
          case 0:
            colorBelowMarket=appColor;
            colorBelowService=Colors.grey;
            break;
          case 1 :
            colorBelowMarket=Colors.grey;
            colorBelowService=appColor;
            break;
        }
      });
    });
  }

}




