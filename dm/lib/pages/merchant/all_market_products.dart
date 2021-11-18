import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:dmarketing/pages/merchant/show_product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/store/product_details.dart';
import 'package:dmarketing/repository/market/market_categories.dart';

class AllMarketProducts extends StatefulWidget {
  String catID;
  AllMarketProducts({this.catID});
  @override
  _AllMarketProductsState createState() => _AllMarketProductsState();
}

class _AllMarketProductsState extends State<AllMarketProducts> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var productsProvider = Provider.of<MarketCategoriesProvider>(context);
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                      translate("navigation_bar.market_products"),
                      style: GoogleFonts.cairo(
                        color: appColor,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.storefront,
                  color: appColor,
                  size: width * 0.08,
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder(
            future: productsProvider.getMarketProducts("${Constant.id}"),
            builder: (context,AsyncSnapshot<List<ProductDetails>> snapshots) {
              if (snapshots.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return snapshots.data==null ||snapshots.data.length==0?
                Center(child:Text(translate("toast.home_no_product",),
                  style: TextStyle(color: appColor),)):
                Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: snapshots.data.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder:
                                (context)=> MarketViewProductDetailsPage(
                              id: "${snapshots.data[index].productId}",
                              productName: "${snapshots.data[index].productName}",
                              images: snapshots.data[index].images,
                              productImage: snapshots.data[index].productImage,
                              price: "${snapshots.data[index].price}",
                              price_after_discount: "${snapshots.data[index].priceSale}",
                              description:"${snapshots.data[index].longDescription}",
                              fav: snapshots.data[index].fav.toString().trim()=="true"?true:false,
                            ),
                            ));
                          },
                          child: Card(
                            color: colorWhite,
                            child: Container(
                              height: height * 0.2-30,
                              width: width,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height * 0.2,
                                    width: width * 0.4 - 12,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage("${snapshots.data[index].productImage}"),
                                        fit: BoxFit.fitHeight,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.06,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: width * 0.3,
                                            child: Text(
                                              "${snapshots.data[index].productName}",
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.08,
                                          ),
                                          Icon(
                                            CupertinoIcons.ellipsis,
                                            color: appColor,
                                            size: width*0.07,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${snapshots.data[index].price}${translate("store.bound")}",
                                            style: GoogleFonts.cairo(
                                                fontWeight: FontWeight.bold,
                                                color: appColor,
                                                fontSize: width * 0.04),
                                          ),
                                          // Text(translate("store.change")),
                                        ],
                                      ),

                                      Container(
                                        padding: EdgeInsets.only(left: width*0.04,right:width*0.04),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: appColor),
                                        ),
                                        child: Text("${snapshots.data[index].priceSale}${translate("store.bound")}",
                                            style: GoogleFonts.cairo(
                                                color: appColor,
                                                fontSize: width * 0.04)),
                                      ),
                                      // SizedBox(
                                      //   height: height * 0.02,
                                      // ),
                                      // Container(
                                      //   margin:
                                      //   const EdgeInsets.symmetric(horizontal: 8),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //     MainAxisAlignment.spaceEvenly,
                                      //     children: [
                                      //       GestureDetector(
                                      //         onTap: () async {
                                      //           // setState(() {
                                      //           //   widget.amount=(int.parse(widget.amount).toInt()+1).toString();
                                      //           // });
                                      //           // await userCart.updateCart(
                                      //           //     productID: widget.uploadid,
                                      //           //     amount: widget.amount).then((value) {});
                                      //         },
                                      //         child: Container(
                                      //             width: width * 0.07,
                                      //             alignment: Alignment.center,
                                      //             decoration: BoxDecoration(
                                      //                 borderRadius:
                                      //                 BorderRadius.circular(7),
                                      //                 border: Border.all(
                                      //                     color: appColor, width: 2)),
                                      //             child: Text(
                                      //               '+',
                                      //               style: GoogleFonts.cairo(
                                      //                   color: appColor),
                                      //             )),
                                      //       ),
                                      //       SizedBox(
                                      //         width: width * 0.03,
                                      //       ),
                                      //       Text('3'),
                                      //       SizedBox(
                                      //         width: width * 0.03,
                                      //       ),
                                      //       GestureDetector(
                                      //         onTap: () async {
                                      //           // if(widget.amount=="1"){
                                      //           //   await userCart.deleteCart(productID:
                                      //           //   widget.uploadid).then((value) {});
                                      //           // }else{
                                      //           //   setState(() {
                                      //           //     widget.amount=(int.parse(widget.amount).toInt()-1).toString();
                                      //           //   });
                                      //           //   await userCart.updateCart(
                                      //           //       productID: widget.uploadid,
                                      //           //       amount: widget.amount).then((value) {});
                                      //           // }
                                      //         },
                                      //         child: Container(
                                      //             width: width * 0.07,
                                      //             alignment: Alignment.center,
                                      //             decoration: BoxDecoration(
                                      //                 borderRadius:
                                      //                 BorderRadius.circular(7),
                                      //                 border: Border.all(
                                      //                     color: appColor, width: 2)),
                                      //             child: Text(
                                      //               '-',
                                      //               style: GoogleFonts.cairo(
                                      //                   color: appColor),
                                      //             )),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            })

    );
  }
}
