import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';

class MarketSubscriptionPage extends StatefulWidget {
  const MarketSubscriptionPage({Key key}) : super(key: key);

  @override
  _MarketSubscriptionPageState createState() => _MarketSubscriptionPageState();
}

class _MarketSubscriptionPageState extends State<MarketSubscriptionPage>  with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        title: Text(
          translate("navigation_bar.subscribe"),
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width ,
              height: height*0.06+4,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical:height*0.01 ,horizontal:width*0.04 ),
              color: colorWhite,
              margin: EdgeInsets.only(bottom: 3),
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: new TabBar(
                  controller: _tabController,
                  tabs: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.1+10),
                      child: Text(translate("market.active"),
                        style: GoogleFonts.cairo(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.1+10),
                      child: Text(translate("market.passive"),
                        style: GoogleFonts.cairo(fontWeight: FontWeight.bold),),
                    ),
                  ],
                  isScrollable: true,
                  indicatorColor: appColor,
                  labelColor: appColor,
                  unselectedLabelColor:Colors.black54 ,
                  unselectedLabelStyle:
                  TextStyle(color: colorDark, fontSize: 18),
                  labelStyle: TextStyle(color: colorDark, fontSize: 18),
                  labelPadding: EdgeInsets.only(left: 4.5,right: 4.5),
                ),
              ),
            ),
            SizedBox(height: height*0.02,),
            Container(
              height: height*0.7-35,
              width: width,
              color: colorWhite,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  setSubscribeKindWidget(height, width),
                  setSubscribeKindWidget(height, width),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setSubscribeKindWidget(double height,double width){
    return Container(
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
                child:Container(
                  decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child:   Text("24 ابريل 2021",
                          style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                              color: appColor,fontSize: width*0.04),),
                      ),
                      SizedBox(height: height*0.02,),
                      Container(
                        color: appColorTwo.withOpacity(0.4),
                        padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("كود الاشتراك",
                              style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                  color: Colors.black54,fontSize: width*0.04),),
                            Text("شهرين", style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                color: Colors.black54,fontSize: width*0.04),)
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: height*0.03,);
          },
          itemCount: 3),
    );
  }

}
