import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:dmarketing/pages/user/orders.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:dmarketing/repository/store/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:dmarketing/elements/CartItemWidget.dart';
import 'package:dmarketing/elements/PermissionDeniedWidget.dart';
import 'package:dmarketing/elements/drawer.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/drawer.dart';



class CartScreen extends StatelessWidget {
  final _scffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var userCart = Provider.of<FavAndCart>(context,listen: false);
    var order = Provider.of<Order>(context,listen: false);
    return Scaffold(
      key: _scffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: appColor),
          title: Text(
            translate("navigation_bar.cart"),
            style: GoogleFonts.cairo(
              color: appColor,
            ),
          ),
        ),
      body: FutureBuilder(
        future:userCart.getCartProducts(),
        builder: (context, AsyncSnapshot<List<ProductDetails>> snapshot) {
          if (snapshot.data == null) {
            return Container(
              width: width,
              height: height * 0.2,
              child: Image.asset(
                'assets/images/loading.gif',
                fit: BoxFit.cover,
              ),
            );
          }else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()
            );
          }else if (snapshot.data.length==0){
            return Center(child: Icon(Icons.remove_shopping_cart,color:Colors.grey,size: 60,));
          }else{
            return Container(
              height: height ,
              width: width,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: snapshot.data.length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return  CartItemWidget(
                            "${snapshot.data[index].productImage}",
                            "",
                            "",
                            "",
                            "${snapshot.data[index].productName}",
                            "",
                            "",
                            "",
                          );
                        }
                    ),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //       padding: EdgeInsets.all(20.0),
                  //       itemCount: snapshot.data.length,
                  //       physics: BouncingScrollPhysics(),
                  //       scrollDirection: Axis.vertical,
                  //       itemBuilder: (context, index) {
                  //         return  Container(
                  //           height: height*0.2,
                  //           width: width,
                  //           alignment: Alignment.center,
                  //           child: CartItemWidget(
                  //             snapshot.data[index].productImage,
                  //             snapshot.data[index].shortDescription,
                  //             snapshot.data[index].marketPhone,
                  //             snapshot.data[index].marketId,
                  //             snapshot.data[index].productName,
                  //             snapshot.data[index].priceSale,
                  //             snapshot.data[index].productId,
                  //             snapshot.data[index].amount,
                  //           ),
                  //         );
                  //       }
                  //   ),
                  // ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: ()async{
                          await order.saveOrder(context: context,owner_id:"${userCart.ownerProductsId}",
                          paymentType: "stripe").then((value) {
                            if(value=="yes"){
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => OrdersPage()),
                                      (Route<dynamic> route) => false);
                            }
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: width,
                              padding:EdgeInsets.all(10),
                              color: appColor.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(translate("myorder.total"),
                                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold,color: appColor),),
                                  SizedBox(width: width*0.02,),
                                  Text("450${translate("store.bound")}",
                                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold,color: appColor),),
                                ],
                              ),
                            ),
                            SizedBox(height: height*0.02,),
                            Container(
                              width: width - 100,
                              height: height*0.06,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: appColor,
                              ),
                              padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                              child: Text(translate("myorder.add_order"),style:
                              GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                  fontSize: width*0.06,color: colorWhite),
                                textAlign: TextAlign.center,),
                            ),
                          ],
                        ),

                      )
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}