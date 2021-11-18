import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:dmarketing/repository/store/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/review.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/signing/login_screen.dart';
import 'package:dmarketing/pages/store/product_details.dart';

class AllProducts extends StatefulWidget {
  String catID,marketName,kind,marketID;
  AllProducts({this.catID,this.marketName,this.kind,this.marketID});

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var categoryProvider = Provider.of<CategoriesProvider>(context);
    var favProvider = Provider.of<FavAndCart>(context);
    var orderProvider = Provider.of<Order>(context);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        centerTitle: true,
        title: Text(
          widget.marketName,
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
      ),
      body: FutureBuilder(
        future: widget.catID!=null?
        categoryProvider.getProducts():
        categoryProvider.getProductsBySeller("${widget.marketID}"),
        builder: (context,AsyncSnapshot<List<ProductDetails>> snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
          } else {
            return  snapshot.data.length==0?
            Center(child:Text(translate("toast.home_no_product",),
              style: TextStyle(color: appColor),)):
            ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    color: colorWhite,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder:
                            (context)=> ProductDetailsPage(
                          id: "${snapshot.data[index].productId}",
                          productName: "${snapshot.data[index].productName}",
                          images: snapshot.data[index].images,
                          price: "${snapshot.data[index].price}",
                          price_after_discount: "${snapshot.data[index].priceSale}",
                          description:"${snapshot.data[index].longDescription}",
                          fav: snapshot.data[index].fav.toString().trim()=="true"?true:false,
                        ),
                        ));
                      },
                      child: Container(
                        width: width-67,
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: width*0.02,),
                            Container(
                              height: height*0.2+10,width: width*0.3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${snapshot.data[index].productImage}"
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            SizedBox(width: width*0.04,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width*0.4-10,
                                      child: Text("${snapshot.data[index].productName}",
                                        style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                            fontSize: width*0.05,color: Colors.black45),
                                        overflow: TextOverflow.ellipsis,),
                                    ),
                                    SizedBox(width: width*0.1,),
                                    IconButton(
                                      onPressed: ()async{
                                        if(Constant.token!=null){
                                          // if(snapshot.data[index].fav==false){
                                            await favProvider.addToFavourite(
                                                productID: "${snapshot.data[index].productId}"
                                            ).then((value) {
                                              if(value.toString().trim()=="yes"){
                                                showToast(translate("toast.favourite"));
                                              }
                                            });
                                          // }else{
                                          //   await favProvider.removeFromFavourite(ID: "${snapshot.data[index].productId}").then((value) {
                                          //     if(value.toString()=="yes"){
                                          //       showToast(translate("toast.dis_favourite"));
                                          //     }
                                          //   });
                                          // }

                                        }else{
                                          Navigator.of(context).push(MaterialPageRoute(builder:
                                              (context)=> LoginScreen()));
                                        }
                                      },
                                      icon: Icon(snapshot.data[index].fav==true?
                                      Icons.favorite:
                                      Icons.favorite_border,color: appColor,),),
                                  ],
                                ),
                                Text("${snapshot.data[index].priceSale}${translate("store.bound")}",style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: appColor,fontSize: width*0.04
                                ),),
                                Row(
                                  children: [
                                    Text("${snapshot.data[index].price}${translate("store.bound")}",
                                      style: GoogleFonts.cairo(decoration: TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold,color: Colors.black38),),
                                    SizedBox(width: width*0.02,),
                                    Text("${translate("store.discount")}${snapshot.data[index].discount}"),
                                  ],
                                ),
                                reView(200),
                                SizedBox(height: height*0.01,),
                                Align(
                                  child:  GestureDetector(
                                    onTap: ()async{
                                      // await orderProvider.saveOrder(context: context,
                                      //     product_id: "${snapshot.data[index].productId}");
                                      if(Constant.token!=null){
                                        customLaunch("tel:${snapshot.data[index].marketPhone}");
                                      }else{
                                        showToast(translate("toast.login"));
                                      }
                                    },
                                    child: Container(
                                      width: width*0.4,
                                      height: height*0.05,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: appColor
                                      ),
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      child: Text(translate("store.contact"),
                                        style: GoogleFonts.cairo(color: colorWhite,
                                            fontWeight: FontWeight.bold,fontSize: width*0.04+2),),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.02,),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: width*0.03,);
                }, itemCount: snapshot.data.length);
          }
        },
      ),
    );
  }
}
