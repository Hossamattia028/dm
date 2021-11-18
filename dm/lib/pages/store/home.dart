import 'dart:async';

import 'package:dmarketing/elements/fullView.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:dmarketing/pages/notifications.dart';
import 'package:dmarketing/pages/store/product_details.dart';
import 'package:dmarketing/pages/user/cart_screen.dart';
import 'package:dmarketing/pages/user/orders.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StoreHomePage extends StatefulWidget {
  @override
  _StoreHomePageState createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  TextEditingController _searchEditingController = new TextEditingController();
  TextEditingController _copounEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);
    var favProvider = Provider.of<FavAndCart>(context, listen: false);
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: PreferredSize(
          child: Container(
            height: height * 0.2 - 35,
            padding:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: new Padding(
              padding: EdgeInsets.only(
                  top: height * 0.03,
                  right: width * 0.02,
                  left: width * 0.02,
                  bottom: height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    translate("store.shop"),
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: colorDark,
                        fontSize: width * 0.04),
                  ),
                  Card(
                    color: colorWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(width: 1, color: appColor)),
                    child: Container(
                      width: width * 0.6,
                      padding: EdgeInsets.only(
                        right: 5,
                      ),
                      child: TextField(
                        autocorrect: true,
                        controller: _searchEditingController,
                        decoration: InputDecoration(
                          hintText: translate("home.search"),
                          counterStyle:
                              GoogleFonts.cairo(fontWeight: FontWeight.bold),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: appColor,
                            size: width * 0.07,
                          ),
                          hintStyle: TextStyle(color: Colors.black45),
                          filled: true,
                          fillColor: colorWhite,
                          contentPadding: EdgeInsets.only(top: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: colorWhite, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: colorWhite, width: 2),
                          ),
                        ),
                        onChanged: (val){
                          setState(() {
                            _searchEditingController.text=val;
                          });
                        },
                        onSubmitted: (val){
                          setState(() {
                            _searchEditingController.text=val;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotificationPage()));
                      },
                      child: Image.asset(
                        "assets/icons/noteficationA.png",
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        width: width * 0.06,
                        height: height * 0.03 + 5,
                      )),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder:
                            (context)=>OrdersPage()));
                      },
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: appColor,
                        size: width*0.1-4,
                      ),
                      // child: Image.asset(
                      //   "assets/icons/add_productA.png",
                      //   alignment: Alignment.center,
                      //   fit: BoxFit.cover,
                      //   width: width * 0.08,
                      //   height: height * 0.03 + 6,
                      // ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: new Size(width, 110.0),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: appColor,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.07, vertical: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate("store.new_products"),
                      style: GoogleFonts.cairo(
                          color: colorWhite, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              translate("store.search_filter"),
                              style: GoogleFonts.cairo(
                                  color: colorWhite,
                                  fontSize: width * 0.03 + 2),
                            ),
                            Icon(
                              Icons.filter_list_alt,
                              color: colorWhite,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: height * 0.6,
                alignment: Alignment.center,
                child: FutureBuilder(
                    future: categoryProvider.getProducts(),
                    builder: (context, AsyncSnapshot<List<ProductDetails>> snapshots) {
                      if (snapshots.data == null) {
                        return Center(child: Container(
                          width: width,
                          height: height * 0.6,
                          child: Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.cover,
                          ),
                        ));
                      } else if (snapshots.hasData) {
                        return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              if(snapshots.data[index].productName.toString().trim().
                              contains(_searchEditingController.text.toString().trim())){
                                return InkWell(
                                    onTap: () {
                                    },
                                    child: FlipCard(
                                      alignment: Alignment.center,
                                      flipOnTouch: true,
                                      front: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Container(
                                            padding:
                                            EdgeInsets.all(width * 0.02 + 2),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey
                                                        .withOpacity(0.3))),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    snapshots.data[index].fav!=true?
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.favorite_border,color: appColor,
                                                        size: width*0.08,),
                                                      onPressed: ()async{
                                                        await favProvider.addToFavourite(productID:"${snapshots.data[index].productId}" ).then((value) {
                                                          if(value=="yes"){
                                                            setState(() {
                                                              snapshots.data[index].fav=true;
                                                            });
                                                          }else{
                                                            setState(() {
                                                              snapshots.data[index].fav=false;
                                                            });
                                                          }
                                                        });
                                                        Timer(Duration(seconds: 1),(){
                                                          setState(() {});
                                                        });
                                                      },
                                                    ):
                                                    GestureDetector(
                                                      onTap: ()async{
                                                        await favProvider.removeFromFavourite(ID:"${snapshots.data[index].productId}").then((value) {
                                                          if(value=="yes"){
                                                            setState(() {
                                                              snapshots.data[index].fav=false;
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        "assets/icons/hartyB.png",
                                                        width: width * 0.1 + 2,
                                                        height: height * 0.03 + 5,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.description,color: appColor,),
                                                      onPressed: (){
                                                        Navigator.of(context).push(MaterialPageRoute(builder:
                                                            (context)=>ProductDetailsPage(
                                                          fav: snapshots.data[index].fav,
                                                          id: snapshots.data[index].productId.toString(),
                                                          productName: snapshots.data[index].productName.toString(),
                                                          productImage: snapshots.data[index].productImage.toString(),
                                                          price:snapshots.data[index].price.toString(),
                                                          price_after_discount:snapshots.data[index].priceSale.toString(),
                                                          description:snapshots.data[index].longDescription.toString(),
                                                        )));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Image.network(
                                                  "${snapshots.data[index].productImage}",
                                                  height: height * 0.1 + 10,
                                                  width: width * 0.5,
                                                ),
                                                SizedBox(
                                                  height: height * 0.03 + 2,
                                                ),
                                                Container(
                                                  height: height*0.09,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(3),
                                                  child: ListView.builder(
                                                    itemCount: 2,
                                                    scrollDirection: Axis.horizontal,
                                                    physics: BouncingScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      return GestureDetector(
                                                        onTap: (){
                                                          fullView(context, "${snapshots.data[index].productImage}");
                                                        },
                                                        child: Image.network(
                                                          "${snapshots.data[index].productImage}",
                                                          height: height * 0.08,
                                                          width: width * 0.2,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${snapshots.data[index].productName}",
                                                      style:
                                                      GoogleFonts.cairo(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color:
                                                          colorDark,
                                                          fontSize:
                                                          width *
                                                              0.04+2),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          " ${snapshots.data[index].price}",
                                                          style: GoogleFonts.cairo(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.red,
                                                              fontSize:
                                                              width * 0.04 +
                                                                  1),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.05,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    // Container(
                                                    //   width: width * 0.6,
                                                    //   padding: EdgeInsets.only(
                                                    //     right: 5,
                                                    //   ),
                                                    //   child: TextField(
                                                    //     autocorrect: true,
                                                    //     controller:
                                                    //     _copounEditingController,
                                                    //     decoration:
                                                    //     InputDecoration(
                                                    //       hintText: " " +
                                                    //           translate(
                                                    //               "store.copun_active") +
                                                    //           " ",
                                                    //       counterStyle:
                                                    //       GoogleFonts.cairo(
                                                    //           fontWeight:
                                                    //           FontWeight
                                                    //               .bold),
                                                    //       hintStyle: TextStyle(
                                                    //           color:
                                                    //           Colors.black45),
                                                    //       filled: true,
                                                    //       fillColor: colorWhite,
                                                    //       contentPadding:
                                                    //       EdgeInsets.only(
                                                    //           top: 10),
                                                    //       enabledBorder:
                                                    //       OutlineInputBorder(
                                                    //         borderRadius:
                                                    //         BorderRadius.all(
                                                    //             Radius
                                                    //                 .circular(
                                                    //                 12.0)),
                                                    //         borderSide: BorderSide(
                                                    //             color: appColor
                                                    //                 .withOpacity(
                                                    //                 0.2),
                                                    //             width: 1),
                                                    //       ),
                                                    //       focusedBorder:
                                                    //       OutlineInputBorder(
                                                    //         borderRadius:
                                                    //         BorderRadius.all(
                                                    //             Radius
                                                    //                 .circular(
                                                    //                 10.0)),
                                                    //         borderSide: BorderSide(
                                                    //             color: appColor
                                                    //                 .withOpacity(
                                                    //                 0.2),
                                                    //             width: 1),
                                                    //       ),
                                                    //     ),
                                                    //     onSubmitted: (_) {},
                                                    //   ),
                                                    // ),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //   MainAxisAlignment.spaceEvenly,
                                                    //   children: [
                                                    //     GestureDetector(
                                                    //       onTap: ()async{
                                                    //         if(amount.toString().contains(",")){
                                                    //           amount = amount.toString().replaceAll(",", "").toString();
                                                    //         }
                                                    //         setState(() {
                                                    //           amount=(int.parse(amount).toInt()+1).toString();
                                                    //           amount = amount+"${snapshots.data[index].productId}";
                                                    //         });
                                                    //       },
                                                    //       child: Container(
                                                    //           width: width * 0.07,
                                                    //           alignment: Alignment.center,
                                                    //           decoration: BoxDecoration(
                                                    //               border: Border.all(
                                                    //                   color: appColor,
                                                    //                   width: 2)),
                                                    //           child: Text('+',style: GoogleFonts.cairo(color: appColor),)),
                                                    //     ),
                                                    //     Text('${amount.toString().replaceAll(",", "").toString().trim()}'),
                                                    //     GestureDetector(
                                                    //       onTap: ()async{
                                                    //
                                                    //       },
                                                    //       child: Container(
                                                    //           width: width * 0.07,
                                                    //           alignment: Alignment.center,
                                                    //           decoration: BoxDecoration(
                                                    //               border: Border.all(
                                                    //                   color: appColor,
                                                    //                   width: 2)),
                                                    //           child: Text('-',style: GoogleFonts.cairo(color: Colors.green),)),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    GestureDetector(
                                                      onTap: () async{
                                                        await favProvider.addToCart(productID: "${snapshots.data[index].productId}").then((value){
                                                          if(value=="yes"){
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) => CartScreen()));
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                            width * 0.04,
                                                            vertical: height *
                                                                0.01),
                                                        width: width*0.9-10,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(30),
                                                        ),
                                                        child: Text(
                                                          translate(
                                                              "activity_cart.add_cart"),
                                                          style:
                                                          GoogleFonts.cairo(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color:
                                                              colorWhite,fontSize: width*0.05-2),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                      back: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Container(
                                            padding:
                                            EdgeInsets.all(width * 0.02 + 2),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey
                                                        .withOpacity(0.3))),
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  "${snapshots.data[index].productImage}",
                                                  height: height * 0.1 + 10,
                                                  width: width * 0.5,
                                                ),
                                                SizedBox(
                                                  height: height * 0.03 + 2,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "VR BOX",
                                                      style: GoogleFonts.cairo(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: colorDark,
                                                          fontSize: width * 0.05),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${snapshots.data[index].price}",
                                                          style: GoogleFonts.cairo(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.red,
                                                              fontSize:
                                                              width * 0.04 +
                                                                  1),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.05,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                    ));
                              }else{
                                return Container();
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: height * 0.01,
                            ),
                            itemCount: snapshots.data.length);
                      } else {
                        return Center(
                            child: Container(
                              width: width,
                              height: height * 0.6,
                              child: Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.cover,
                              ),
                            ));
                      }
                    }),
              ),
            ],
          ),
        ));
  }
  String amount = "0";
}
