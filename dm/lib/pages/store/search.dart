import 'package:dmarketing/helper/showtoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  String keyword,startPrice,endPrice;
  SearchPage({this.keyword,this.startPrice,this.endPrice});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController myScrollController ;
  @override
  void initState() {
    myScrollController = ScrollController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var productsProvider = Provider.of<CategoriesProvider>(context);
    var cartUser = Provider.of<FavAndCart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("store.search")+
            "${widget.keyword==""||widget.keyword=="filter"?"....":widget.keyword}",
          style: GoogleFonts.cairo(
              fontSize: height*0.03,
              fontWeight: FontWeight.bold,
              color: appColor
          ),),
        backgroundColor: colorWhite,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: appColor,opacity: 12,size: 25),
      ),
      backgroundColor: colorWhite,
      // body:  widget.keyword=="filter"?
      // FutureBuilder(
      //     future: productsProvider.getProductFilter("${widget.startPrice}","${widget.endPrice}"),
      //     builder: (context,AsyncSnapshot<List<ProductDetails>> snapshots) {
      //       if (snapshots.data == null) {
      //         return Center(child: CircularProgressIndicator());
      //       }else if(snapshots.data.length==0) {
      //         return Center(child: Text(translate("toast.home_no_product")),);
      //       }
      //       else {
      //         return Container(
      //           alignment: Alignment.topCenter,
      //           width:width,
      //           height: height,
      //           color: colorWhite,
      //           padding: EdgeInsets.all(5),
      //           child:  GridView.builder(
      //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //             ),
      //             shrinkWrap: true,
      //             physics: BouncingScrollPhysics(),
      //             controller: myScrollController,
      //             padding: EdgeInsets.zero,
      //             itemCount: snapshots.data.length,
      //             itemBuilder: (context, index) {
      //               return GestureDetector(
      //                 onTap: (){
      //                   Navigator.of(context).push(MaterialPageRoute(builder:
      //                       (context)=>ProductDetail(
      //                     priceSale:  snapshots.data[index].price.toString(),
      //                     productName: snapshots.data[index].productName.toString(),
      //                     longdescription: snapshots.data[index].longDescription.toString(),
      //                     categoryId:snapshots.data[index].categoryId.toString(),
      //                     productId:snapshots.data[index].productId.toString(),
      //                     images: snapshots.data[index].images,
      //                     discount: snapshots.data[index].discount.toString(),
      //                         partnerName: snapshots
      //                             .data[index].partner,
      //                   )));
      //                 },
      //                 child: Card(
      //                   child: Container(
      //                       alignment: Alignment.center,
      //                       padding: EdgeInsets.only(left: 3,right: 4,top: 0,bottom: 0),
      //                       color: colorWhite,
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Stack(
      //                             children: [
      //                               CachedNetworkImage(
      //                                 fit: BoxFit.contain,
      //                                 alignment: Alignment.center,
      //                                 height: height*0.1+10,
      //                                 width: width*0.4,
      //                                 imageUrl:
      //                                 "${snapshots.data[index].images.first.image.toString()}",
      //                                 placeholder: (context, url) =>
      //                                     Image.asset(
      //                                       'assets/images/loading.gif',
      //                                       fit: BoxFit.contain,
      //                                     ),
      //                                 errorWidget:
      //                                     (context, url, error) =>
      //                                     Icon(Icons.error),
      //                               ),
      //                               IconButton(
      //                                 icon: Icon(
      //                                   snapshots.data[index].fav=="fav"?
      //                                   Icons.favorite:Icons.favorite_border,color: Colors.red,),
      //                                 onPressed: ()async{
      //                                   if (Constant.id == null) {
      //                                     showToast(translate("toast.login"));
      //                                     Navigator.of(context).push(
      //                                         MaterialPageRoute(builder: (context) => MainRegister()));
      //                                   } else {
      //                                     Navigator.of(context).push(
      //                                         MaterialPageRoute(
      //                                             builder: (context) =>
      //                                                 ProductDetail(
      //                                                   images: snapshots
      //                                                       .data[index]
      //                                                       .images,
      //                                                   longdescription:
      //                                                   snapshots
      //                                                       .data[
      //                                                   index]
      //                                                       .longDescription,
      //                                                   productName: snapshots
      //                                                       .data[index]
      //                                                       .productName,
      //                                                   priceSale:
      //                                                   snapshots
      //                                                       .data[
      //                                                   index]
      //                                                       .price,
      //                                                   discount: snapshots
      //                                                       .data[index]
      //                                                       .discount,
      //                                                   productId: snapshots
      //                                                       .data[index]
      //                                                       .productId,
      //                                                 )));
      //                                   }
      //                                 },
      //                               ),
      //                             ],
      //                           ),
      //                           Row(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Text("${snapshots.data[index].productName}",overflow: TextOverflow.ellipsis,
      //                                 style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
      //                                     fontSize: width * 0.03),),
      //                               IconButton(
      //                                 onPressed: ()async{
      //                                   await cartUser.addToCart(
      //                                       amount: "0",
      //                                       productId:
      //                                       "${snapshots.data[index].productId}");
      //                                 },
      //                                 icon: Icon(Icons.shopping_cart,color: appColor,),
      //                               ),
      //                             ],
      //                           ),
      //                           Row(
      //                             crossAxisAlignment:
      //                             CrossAxisAlignment.center,
      //                             mainAxisAlignment:
      //                             MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Text(
      //                                 "${(double.parse(snapshots.data[index].price).toDouble() - double.parse(snapshots.data[index].discount).toDouble()).toString()}"
      //                                     +translate("store.bound"),
      //                                 style: GoogleFonts.cairo(
      //                                   color: appColor,
      //                                 ),
      //                               ),
      //                               SizedBox(
      //                                 width: width * 0.04,
      //                               ),
      //                               snapshots.data[index].discount.toString()!="0"?
      //                               Text(
      //                                 "${snapshots.data[index].price}"+translate("store.bound"),
      //                                 style: GoogleFonts.cairo(
      //                                     color: colorDark
      //                                         .withOpacity(0.4),
      //                                     fontSize: 13,
      //                                     decoration: TextDecoration
      //                                         .lineThrough),
      //                               ):Text(""),
      //                             ],
      //                           ),
      //                         ],
      //                       )
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         );
      //       }
      //     }):
      // FutureBuilder(
      //     future: productsProvider.getSearch("${widget.keyword}"),
      //     builder: (context,AsyncSnapshot<List<ProductDetails>> snapshots) {
      //       if (snapshots.data == null) {
      //         return Center(child: CircularProgressIndicator());
      //       }else if(snapshots.data.length==0) {
      //         return Center(child: Text(translate("toast.home_no_product")),);
      //       }
      //       else {
      //         return Container(
      //           alignment: Alignment.topCenter,
      //           width:width,
      //           height: height,
      //           color: colorWhite,
      //           padding: EdgeInsets.all(5),
      //           child: GridView.builder(
      //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //             ),
      //             shrinkWrap: true,
      //             physics: BouncingScrollPhysics(),
      //             controller: myScrollController,
      //             padding: EdgeInsets.zero,
      //             itemCount: snapshots.data.length,
      //             itemBuilder: (context, index) {
      //               return GestureDetector(
      //                 onTap: (){
      //                   Navigator.of(context).push(MaterialPageRoute(builder:
      //                       (context)=>ProductDetail(
      //                     priceSale:  snapshots.data[index].price.toString(),
      //                     productName: snapshots.data[index].productName.toString(),
      //                     longdescription: snapshots.data[index].longDescription.toString(),
      //                     categoryId:snapshots.data[index].categoryId.toString(),
      //                     productId:snapshots.data[index].productId.toString(),
      //                     images: snapshots.data[index].images,
      //                     discount: snapshots.data[index].discount.toString(),
      //                   )));
      //                 },
      //                 child: Card(
      //                   child: Container(
      //                       alignment: Alignment.center,
      //                       padding: EdgeInsets.only(left: 3,right: 4,top: 0,bottom: 0),
      //                       color: colorWhite,
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Stack(
      //                             children: [
      //                               CachedNetworkImage(
      //                                 fit: BoxFit.contain,
      //                                 alignment: Alignment.center,
      //                                 height: height*0.1+10,
      //                                 width: width*0.4,
      //                                 imageUrl:
      //                                 "${snapshots.data[index].images.first.image.toString()}",
      //                                 placeholder: (context, url) =>
      //                                     Image.asset(
      //                                       'assets/images/loading.gif',
      //                                       fit: BoxFit.contain,
      //                                     ),
      //                                 errorWidget:
      //                                     (context, url, error) =>
      //                                     Icon(Icons.error),
      //                               ),
      //                               IconButton(
      //                                 icon: Icon(
      //                                   snapshots.data[index].fav=="fav"?
      //                                   Icons.favorite:Icons.favorite_border,color: Colors.red,),
      //                                 onPressed: ()async{
      //                                   if (Constant.id == null) {
      //                                     showToast(translate("toast.login"));
      //                                     Navigator.of(context).push(
      //                                         MaterialPageRoute(builder: (context) => MainRegister()));
      //                                   } else {
      //                                     Navigator.of(context).push(
      //                                         MaterialPageRoute(
      //                                             builder: (context) =>
      //                                                 ProductDetail(
      //                                                   images: snapshots
      //                                                       .data[index]
      //                                                       .images,
      //                                                   longdescription:
      //                                                   snapshots
      //                                                       .data[
      //                                                   index]
      //                                                       .longDescription,
      //                                                   productName: snapshots
      //                                                       .data[index]
      //                                                       .productName,
      //                                                   priceSale:
      //                                                   snapshots
      //                                                       .data[
      //                                                   index]
      //                                                       .price,
      //                                                   discount: snapshots
      //                                                       .data[index]
      //                                                       .discount,
      //                                                   productId: snapshots
      //                                                       .data[index]
      //                                                       .productId,
      //                                                 )));
      //                                   }
      //                                 },
      //                               ),
      //                             ],
      //                           ),
      //                           Row(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Text("${snapshots.data[index].productName}",overflow: TextOverflow.ellipsis,
      //                                 style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
      //                                     fontSize: width * 0.03),),
      //                               IconButton(
      //                                 onPressed: ()async{
      //                                   await cartUser.addToCart(
      //                                       amount: "0",
      //                                       productId:
      //                                       "${snapshots.data[index].productId}");
      //                                 },
      //                                 icon: Icon(Icons.shopping_cart,color: appColor,),
      //                               ),
      //                             ],
      //                           ),
      //                           Row(
      //                             crossAxisAlignment:
      //                             CrossAxisAlignment.center,
      //                             mainAxisAlignment:
      //                             MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Text(
      //                                 "${(double.parse(snapshots.data[index].price).toDouble() - double.parse(snapshots.data[index].discount).toDouble()).toString()}"
      //                                 +translate("store.bound"),
      //                                 style: GoogleFonts.cairo(
      //                                   color: appColor,
      //                                 ),
      //                               ),
      //                               SizedBox(
      //                                 width: width * 0.04,
      //                               ),
      //                               snapshots.data[index].discount.toString()!="0"?
      //                               Text(
      //                                 "${snapshots.data[index].price}"+translate("store.bound"),
      //                                 style: GoogleFonts.cairo(
      //                                     color: colorDark
      //                                         .withOpacity(0.4),
      //                                     fontSize: 13,
      //                                     decoration: TextDecoration
      //                                         .lineThrough),
      //                               ):Text(""),
      //                             ],
      //                           ),
      //                         ],
      //                       )
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         );
      //       }
      //     }),
    );
  }
}
