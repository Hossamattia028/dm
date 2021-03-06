import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class CartItemWidget extends StatefulWidget {
  String productImage,shortDescription, marketPhone,authuidMarket,
      productName,priceSale,uploadid,amount;

  CartItemWidget(
      this.productImage,this.shortDescription
      ,this.marketPhone,this.authuidMarket,
      this.productName,this.priceSale,this.uploadid,this.amount);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}
class _CartItemWidgetState extends State<CartItemWidget> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var userCart = Provider.of<FavAndCart>(context);
    return InkWell(
      onTap: () {

      },
      child:  Card(
        color: colorWhite,
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: height*0.2-20,
          width: width,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height*0.2,width: width*0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "${widget.productImage}"
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: width*0.06,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.productName}",
                        style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                            fontSize: width*0.05,color: Colors.black45),),
                      SizedBox(width: width*0.1,),
                      Icon(Icons.delete,color: appColor,)
                    ],
                  ),
                  Text("${widget.priceSale} ${translate("store.bound")}",style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      color: appColor,fontSize: width*0.04
                  ),),
                  // Row(
                  //   children: [
                  //     Text("490${translate("store.bound")}",
                  //       style: GoogleFonts.cairo(decoration: TextDecoration.lineThrough,
                  //           fontWeight: FontWeight.bold,color: Colors.black38),),
                  //     SizedBox(width: width*0.02,),
                  //     Text("?????? 10%"),
                  //   ],
                  // ),
                  SizedBox(height: height*0.01,),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: ()async{
                            // setState(() {
                            //   widget.amount=(int.parse(widget.amount).toInt()+1).toString();
                            // });
                            // await userCart.updateCart(
                            //     productID: widget.uploadid,
                            //     amount: widget.amount).then((value) {});
                          },
                          child: Container(
                              width: width * 0.07,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: appColor,
                                      width: 2)),
                              child: Text('+',style: GoogleFonts.cairo(color: appColor),)),
                        ),
                        SizedBox(width: width*0.03,),
                        Text('${widget.amount}3'),
                        SizedBox(width: width*0.03,),
                        GestureDetector(
                          onTap: ()async{
                            // if(widget.amount=="1"){
                            //   await userCart.deleteCart(productID:
                            //   widget.uploadid).then((value) {});
                            // }else{
                            //   setState(() {
                            //     widget.amount=(int.parse(widget.amount).toInt()-1).toString();
                            //   });
                            //   await userCart.updateCart(
                            //       productID: widget.uploadid,
                            //       amount: widget.amount).then((value) {});
                            // }
                          },
                          child: Container(
                              width: width * 0.07,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: appColor,
                                      width: 2)),
                              child: Text('-',style: GoogleFonts.cairo(color: appColor),)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.01,),


                ],
              ),
            ],
          ),
        ),
      ),

    );
  }

}
