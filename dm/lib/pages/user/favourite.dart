import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:dmarketing/pages/store/product_details.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/PermissionDeniedWidget.dart';
import 'package:dmarketing/elements/review.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/root_pages.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
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
    var favProvider = Provider.of<FavAndCart>(context);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        title: Text(
          translate("favourite.title"),
          style: GoogleFonts.cairo(
              color: colorDark,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.05),
        ),
      ),
      body: Constant.id != null
          ? FutureBuilder(
              future: favProvider.getFavProducts(),
              builder:
                  (context, AsyncSnapshot<List<ProductDetails>> snapshots) {
                if (snapshots.data == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return snapshots.data.length == 0
                      ? Center(
                          child: Text(
                          translate(
                            "favourite.empty",
                          ),
                          style: TextStyle(color: appColor),
                        ))
                      : Container(
                          alignment: Alignment.topCenter,
                          width: width,
                          height: height,
                          padding: EdgeInsets.only(top: height * 0.02),
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
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
                                    child: Card(
                                      color: colorWhite,
                                      child: Container(
                                        width: width - 67,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await favProvider
                                                    .removeFromFavourite(
                                                        ID: "${snapshots.data[index].productId}")
                                                    .then((value) {
                                                  if (value.toString() ==
                                                      "yes") {
                                                    showToast(translate(
                                                        "toast.dis_favourite"));
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    RootPages(
                                                                      checkPage:
                                                                          "2",
                                                                    )));
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: width * 0.09,
                                                height: height * 0.2,
                                                color: appColor.withOpacity(0.4),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  CupertinoIcons.delete_solid,
                                                  color: appColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.05,
                                            ),
                                            Container(
                                              height: height * 0.2 + 10,
                                              width: width * 0.3,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${snapshots.data[index].productImage}"),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.06,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${snapshots.data[index].productName}",
                                                  style: GoogleFonts.cairo(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.05,
                                                      color: Colors.black45),
                                                ),
                                                Text(
                                                  "${snapshots.data[index].priceSale}${translate("store.bound")}",
                                                  style: GoogleFonts.cairo(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: appColor,
                                                      fontSize: width * 0.04),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${snapshots.data[index].price}${translate("store.bound")}",
                                                      style: GoogleFonts.cairo(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black38),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.02,
                                                    ),
                                                    Text(
                                                        "${translate("store.before_discount")}"),
                                                  ],
                                                ),
                                                reView(200),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox();
                              },
                              itemCount: snapshots.data.length));
                }
              })
          : PermissionDeniedWidget(),
    );
  }
}
