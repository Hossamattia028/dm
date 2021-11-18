import 'package:dmarketing/models/store/Orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/drawer.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/notifications.dart';
import 'package:dmarketing/pages/store/search.dart';
import 'package:dmarketing/repository/market/market_order.dart';

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({Key key}) : super(key: key);

  @override
  _AllOrdersPageState createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController myScrollController;
  @override
  void initState() {
    myScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var orderProvider = Provider.of<MarketOrder>(context);
    return Scaffold(
        key: _scaffoldKey,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: appColor,
                    size: width * 0.08,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  translate("navigation_bar.market_order"),
                  style: GoogleFonts.cairo(
                    color: appColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        body:
            // Constant.id != null?
            FutureBuilder(
                future: orderProvider.getOrders(),
                builder: (context, AsyncSnapshot<List<OrdersModel>> snapshots) {
                    if (snapshots.data == null) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return snapshots.data==null ||snapshots.data.length==0?
                      Center(child:Text(translate("myorder.empty",),
                        style: TextStyle(color: appColor),))
                        : Container(
                            alignment: Alignment.topCenter,
                            width: width,
                            height: height,
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: appColor,
                                                  maxRadius: 15,
                                                  child: Text(
                                                    'H',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "اسم المستخدم",
                                                  style: GoogleFonts.cairo(
                                                    fontWeight: FontWeight.bold,
                                                    color: appColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "${snapshots.data[index].date}",
                                              style: GoogleFonts.cairo(
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width,
                                        color: appColor.withOpacity(0.2),
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  translate(
                                                      "myorder.order_number"),
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                Text(
                                                  "${snapshots.data[index].orderNumber}",
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Container(
                                                alignment: Alignment.topCenter,
                                                width: width,
                                                height: height * 0.09,
                                                child: ListView.separated(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                          onTap: () {},
                                                          child: Card(
                                                            child: Container(
                                                              color: colorWhite,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 4,
                                                                      right: 4),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    height: height *
                                                                            0.1 +
                                                                        10,
                                                                    width: width *
                                                                            0.2 +
                                                                        5,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            "assets/images/summer-collection-sale-banner-style_23-2148520739.png"),
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.02,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "جاكيت نبيتى ",
                                                                        style: GoogleFonts.cairo(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize: width * 0.03 +
                                                                                3,
                                                                            color:
                                                                                Colors.black45),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "العدد",
                                                                            style:
                                                                                GoogleFonts.cairo(fontSize: width * 0.03, color: Colors.black),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.01,
                                                                          ),
                                                                          Text(
                                                                              "2"),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    },
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox(
                                                        width: width * 0.04,
                                                      );
                                                    },
                                                    itemCount: 10)),
                                            Row(
                                              children: [
                                                Text(
                                                  "اجمالى السعر:",
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                Text(
                                                  "654${translate("store.bound")}",
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "العنوان:",
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                Text(
                                                  "16 شارع 9 المعادى",
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    padding: EdgeInsets.only(
                                                        left: 14,
                                                        right: 14,
                                                        top: 3,
                                                        bottom: 3),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: appColor),
                                                    child: Text(
                                                      "قبول",
                                                      style: GoogleFonts.cairo(
                                                          color: colorWhite,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: height * 0.03,
                                  );
                                },
                                itemCount: snapshots.data.length));
                  }
                })
        // :PermissionDeniedWidget(),
        );
  }


}
