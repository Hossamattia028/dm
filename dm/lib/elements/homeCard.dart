import 'package:dmarketing/models/store/Categories.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/review.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/pages/store/categories.dart';

class CardHome extends StatefulWidget {
 String kind, title, imgPath;
 CardHome(this.kind,this.title,this.imgPath);

  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var categoryProvider = Provider.of<CategoriesProvider>(context);
    var favUser = Provider.of<FavAndCart>(context);
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: height*0.01),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height*0.2,
              width: width,
              margin: EdgeInsets.only(right: Constant.lang=="ar"?
              width*0.03:0.0,left: Constant.lang!="ar"?width*0.03:0.0),
              child:FutureBuilder(
                future: categoryProvider.getCategories(home: true,asMarket:widget.kind=="market"?true:false ),
                builder: (context,AsyncSnapshot<List<Categories>> snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
                  } else {
                    return  snapshot.data.length==0?
                    Center(child:Text(widget.kind=="market"?
                    translate("store.no_market",):translate("store.no_service",),
                      style: TextStyle(color: appColor),)):
                    ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: width*0.04),
                        padding: EdgeInsets.all(2),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder:
                                  (context)=>CategoriesPage(
                                categoryName:"${snapshot.data[index].name}" ,
                                catID: "${snapshot.data[index].id}" ,
                                productsPage: true, kindCategory: "${widget.kind}",
                              )));
                              // fullView(context, "${snapshots.data[index].image.toString()}");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height*0.2-50,
                                  width: width*0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: appColor),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey[100],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          '${snapshot.data[index].image}',
                                        ),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(height: height*0.01,),
                                Container(
                                  width: width*0.3,
                                  alignment: Alignment.center,
                                  child: Text("${snapshot.data[index].name}",
                                    style: GoogleFonts.cairo(color:colorDark,
                                        fontWeight: FontWeight.bold,fontSize: width*0.04-1),
                                    overflow: TextOverflow.ellipsis,),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:
                        (context)=>CategoriesPage(
                      categoryName:"all" ,
                      kindCategory: "${widget.kind}",
                      productsPage: false,
                    )));
                  },
                  child: Text(
                    translate("store.show_all"),
                    style: TextStyle(
                        color: appColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: width*0.02,),
                Icon(
                  Icons.arrow_forward,
                  color: appColor,
                  size: width*0.06,
                )
              ],
            ),
            // widget.kind=="market"?
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Container(
            //       height: height*0.3-10,
            //       width: width,
            //       child: FutureBuilder(
            //         future: categoryProvider.getSellers(),
            //         builder: (context,AsyncSnapshot<List<SellerModel>> snapshot) {
            //           if (snapshot.data == null) {
            //             return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
            //           } else {
            //             return  snapshot.data.length==0?
            //             Center(child:Text(translate("store.no_market",),
            //               style: TextStyle(color: appColor),)):
            //             ListView.separated(
            //                 physics: BouncingScrollPhysics(),
            //                 itemBuilder: (context, index) {
            //                   return GestureDetector(
            //                     onTap: (){
            //                       Navigator.of(context).push(MaterialPageRoute(builder:
            //                           (context)=>MarketInfoPage(kind: "market",
            //                         id: "${snapshot.data[index].id}",
            //                         name: "${snapshot.data[index].name}",
            //                         image: "${snapshot.data[index].image}",
            //                         address: "${snapshot.data[index].address}",
            //                         phone: "${snapshot.data[index].mobilePhone}",
            //                       )));
            //                     },
            //                     child: Container(
            //                       width: width,
            //                       height: height*0.1+20,
            //                       padding: EdgeInsets.symmetric(horizontal: width*0.04,
            //                           vertical: height*0.01),
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(20),
            //                           color: appColorTwo.withOpacity(0.2)
            //                       ),
            //                       child: Row(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Row(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               Container(
            //                                 height: height*0.05,
            //                                 width: width*0.1,
            //                                 decoration: BoxDecoration(
            //                                   image: DecorationImage(
            //                                     image: snapshot.data[index].image==""||snapshot.data[index].image==null?
            //                                     AssetImage("assets/images/Vatrinty Logo.jpg"):
            //                                     NetworkImage("${snapshot.data[index].image}"),
            //                                     fit: BoxFit.cover,
            //                                   ),
            //                                   borderRadius: BorderRadius.circular(50),
            //                                   border: Border.all(width: 1),
            //                                 ),
            //                               ),
            //                               SizedBox(width: width*0.05,),
            //                               Column(
            //                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                 children: [
            //                                   SizedBox(
            //                                     width: width*0.4+20,
            //                                     child: Text("${snapshot.data[index].name}",
            //                                       style: GoogleFonts.cairo(color: Colors.black54,
            //                                           fontWeight: FontWeight.bold,fontSize: width*0.04),overflow: TextOverflow.ellipsis,),
            //                                   ),
            //                                   Text(" 35 "+translate("store.product"),
            //                                     style: GoogleFonts.cairo(color: appColor,
            //                                         fontSize: width*0.04),),
            //                                   reView(140),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.center,
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Row(
            //                                 mainAxisAlignment: MainAxisAlignment.center,
            //                                 children: [
            //                                   Icon(Icons.location_pin,color: appColor,
            //                                     size: width*0.05,),
            //                                   Container(
            //                                     width: width*0.1,
            //                                     height: height*0.03,
            //                                     child: Text("${snapshot.data[index].address}",
            //                                       style: GoogleFonts.cairo(
            //                                         color: Colors.grey,
            //                                       ),overflow: TextOverflow.ellipsis,),
            //                                   ),
            //                                 ],
            //                               ),
            //                               GestureDetector(
            //                                 onTap: (){
            //                                   if(Constant.token!=null){
            //                                     customLaunch("tel:${snapshot.data[index].mobilePhone}");
            //                                   }else{
            //                                     Navigator.of(context).push(MaterialPageRoute(builder:
            //                                         (context)=> LoginScreen()));
            //                                   }
            //                                 },
            //                                 child: Container(
            //                                   width: width*0.2,
            //                                   alignment: Alignment.center,
            //                                   decoration: BoxDecoration(
            //                                     borderRadius: BorderRadius.circular(100),
            //                                     color: appColor,
            //                                   ),
            //                                   padding: EdgeInsets.only(right: 12,left: 12,top: 5,bottom: 5),
            //                                   child: Text(translate("store.contact"),
            //                                     style: GoogleFonts.cairo(color: colorWhite,
            //                                         fontWeight: FontWeight.bold),),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   );
            //                 },
            //                 separatorBuilder: (context, index) {
            //                   return SizedBox(height: height*0.02,);
            //                 },
            //                 itemCount: 2);
            //           }
            //         },
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(left: width*0.02,right: width*0.02),
            //       child: GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
            //               AllMarketPage(title: translate("store.sallers"),
            //                 kind: "market",)));
            //         },
            //         child: Text(
            //           translate("home.show_all"),
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold, color:appColor),
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: height*0.01,),
            //   ],
            // ):
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     // Row(
            //     //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     //   children: [
            //     //     GestureDetector(
            //     //       child: Container(
            //     //           height: height*0.05,
            //     //           alignment: Alignment.center,
            //     //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
            //     //           ),
            //     //           decoration: BoxDecoration(
            //     //             borderRadius: BorderRadius.circular(20),
            //     //             color: appColorTwo,
            //     //             border: Border.all(width: 1,color: Colors.grey),
            //     //           ),
            //     //           child: Text("طبية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
            //     //               color: colorWhite),)
            //     //       ),
            //     //     ),
            //     //     GestureDetector(
            //     //       child: Container(
            //     //           height: height*0.05,
            //     //           alignment: Alignment.center,
            //     //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
            //     //           ),
            //     //           decoration: BoxDecoration(
            //     //             borderRadius: BorderRadius.circular(20),
            //     //             color: colorWhite,
            //     //             border: Border.all(width: 1,color: Colors.grey),
            //     //           ),
            //     //           child: Text("تعليمية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
            //     //               color: appColor),)
            //     //       ),
            //     //     ),
            //     //     GestureDetector(
            //     //       child: Container(
            //     //           height: height*0.05,
            //     //           alignment: Alignment.center,
            //     //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
            //     //           ),
            //     //           decoration: BoxDecoration(
            //     //             borderRadius: BorderRadius.circular(20),
            //     //             color: colorWhite,
            //     //             border: Border.all(width: 1,color: Colors.grey),
            //     //           ),
            //     //           child: Text("هندسية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
            //     //               color: appColor),)
            //     //       ),
            //     //     ),
            //     //   ],
            //     // ),
            //     // SizedBox(height: height*0.01,),
            //     Container(
            //       height: height*0.3,
            //       width: width,
            //       child: FutureBuilder(
            //         future: categoryProvider.getSellersServices(),
            //         builder: (context,AsyncSnapshot<List<SellerModel>> snapshot) {
            //           if (snapshot.data == null) {
            //             return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
            //           } else {
            //             return  snapshot.data.length==0?
            //             Center(child:Text(translate("store.no_service",),
            //               style: TextStyle(color: appColor),)):
            //             ListView.separated(
            //                 physics: BouncingScrollPhysics(),
            //                 itemBuilder: (context, index) {
            //                   return GestureDetector(
            //                     onTap: (){
            //                       Navigator.of(context).push(MaterialPageRoute(builder:
            //                           (context)=>MarketInfoPage(kind: "service",
            //                               id: "${snapshot.data[index].id}",
            //                               name: "${snapshot.data[index].name}",
            //                               image: "${snapshot.data[index].image}",
            //                               address: "${snapshot.data[index].address.replaceAll("null", "").toString()}",
            //                               phone: "${snapshot.data[index].mobilePhone}",
            //                               desc: "${snapshot.data[index].desc}",
            //                               jobTitle: "${snapshot.data[index].jobTitle}",
            //                       )));
            //                     },
            //                     child: Container(
            //                       width: width,
            //                       height: height*0.1+20,
            //                       padding: EdgeInsets.symmetric(horizontal: width*0.04,
            //                           vertical: height*0.01),
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(20),
            //                           color: appColorTwo.withOpacity(0.2)
            //                       ),
            //                       child: Row(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Row(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               Container(
            //                                 height: height*0.05,
            //                                 width: width*0.1,
            //                                 decoration: BoxDecoration(
            //                                   image: DecorationImage(
            //                                     image: NetworkImage("${snapshot.data[index].image}"),
            //                                     fit: BoxFit.cover,
            //                                   ),
            //                                   borderRadius: BorderRadius.circular(50),
            //                                   border: Border.all(width: 1),
            //                                 ),
            //                               ),
            //                               SizedBox(width: width*0.05,),
            //                               Column(
            //                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text("${snapshot.data[index].name}",
            //                                     style: GoogleFonts.cairo(color: Colors.black54,
            //                                         fontWeight: FontWeight.bold,fontSize: width*0.05),),
            //                                   Text("${snapshot.data[index].jobTitle}",
            //                                     style: GoogleFonts.cairo(color: appColor,
            //                                         fontSize: width*0.04),),
            //                                   reView(140),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.center,
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Row(
            //                                 children: [
            //                                   Icon(Icons.location_pin,color: appColor,
            //                                     size: width*0.05,),
            //                                   Text(snapshot.data[index].address.toString()=="null"?"الموقع"
            //                                       :"${snapshot.data[index].address}",style: GoogleFonts.cairo(
            //                                     color: Colors.grey,
            //                                   ),),
            //                                 ],
            //                               ),
            //                               GestureDetector(
            //                                 onTap: (){
            //                                   if(Constant.token!=null){
            //                                     customLaunch("tel:${snapshot.data[index].mobilePhone}");
            //                                   }else{
            //                                     Navigator.of(context).push(MaterialPageRoute(builder:
            //                                         (context)=> LoginScreen()));
            //                                   }
            //                                 },
            //                                 child: Container(
            //                                   width: width*0.2,
            //                                   alignment: Alignment.center,
            //                                   decoration: BoxDecoration(
            //                                     borderRadius: BorderRadius.circular(100),
            //                                     color: appColor,
            //                                   ),
            //                                   padding: EdgeInsets.only(right: 12,left: 12,top: 5,bottom: 5),
            //                                   child: Text(translate("store.contact"),
            //                                     style: GoogleFonts.cairo(color: colorWhite,
            //                                         fontWeight: FontWeight.bold),),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   );
            //                 },
            //                 separatorBuilder: (context, index) {
            //                   return SizedBox(height: height*0.02,);
            //                 },
            //                 itemCount: 2);
            //           }
            //         },
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(left: width*0.02,right: width*0.02),
            //       child: GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
            //               AllMarketPage(title: translate("store.sallers_serivces"),
            //                 kind: "service",)));
            //         },
            //         child: Text(
            //           translate("home.show_all"),
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold, color:appColor),
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: height*0.01,),
            //   ],
            // ),

            SizedBox(height: height*0.02,),
          ],
        ),
      ),
    );
  }
}























// Container(
//   color: appColorTwo.withOpacity(0.2),
//   padding: EdgeInsets.all(10),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GestureDetector(
//             child: Container(
//               width: width*0.2+20,
//               height: height*0.1+15,
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: appColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child:Image.asset("$imgPath"),
//             ),
//             onTap: (){
//             },
//           ),
//           SizedBox(height: height*0.02,),
//           Text("$title",
//             style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
//                 color: appColor,fontSize: width*0.04),),
//         ],
//       ),
//       Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 17,right: 17,top: 5,bottom: 5),
//                 decoration: BoxDecoration(
//                     color: colorWhite,
//                     borderRadius: BorderRadius.circular(100)
//                 ),
//                 child: Text("قميص",style:
//                 GoogleFonts.cairo(fontSize:width*0.04,color: appColor ),),
//               ),
//               SizedBox(width: width*0.03,),
//               Container(
//                 padding: EdgeInsets.only(left: 17,right: 17,top: 5,bottom: 5),
//                 decoration: BoxDecoration(
//                     color: colorWhite,
//                     borderRadius: BorderRadius.circular(100)
//                 ),
//                 child: Text("قميص",style:
//                 GoogleFonts.cairo(fontSize:width*0.04,color: appColor ),),
//               ),
//             ],
//           ),
//           SizedBox(height: height*0.02,),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 17,right: 17,top: 5,bottom: 5),
//                 decoration: BoxDecoration(
//                     color: colorWhite,
//                     borderRadius: BorderRadius.circular(100)
//                 ),
//                 child: Text("قميص",style:
//                 GoogleFonts.cairo(fontSize:width*0.04,color: appColor ),),
//               ),
//               SizedBox(width: width*0.03,),
//               Container(
//                 padding: EdgeInsets.only(left: 17,right: 17,top: 5,bottom: 5),
//                 decoration: BoxDecoration(
//                     color: colorWhite,
//                     borderRadius: BorderRadius.circular(100)
//                 ),
//                 child: Text("قميص",style:
//                 GoogleFonts.cairo(fontSize:width*0.04,color: appColor ),),
//               ),
//             ],
//           ),
//           SizedBox(height: height*0.02,),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 17,right: 17,top: 5,bottom: 5),
//                 decoration: BoxDecoration(
//                     color: appColor,
//                     borderRadius: BorderRadius.circular(100)
//                 ),
//                 child: Text("جاكيت",style:
//                 GoogleFonts.cairo(fontSize:width*0.04,color: colorWhite ),),
//               ),
//               SizedBox(width: width*0.03,),
//               Container(
//                 padding: EdgeInsets.only(left: 17,right: 17,top: 5,bottom: 5),
//                 decoration: BoxDecoration(
//                     color: colorWhite,
//                     borderRadius: BorderRadius.circular(100)
//                 ),
//                 child: Text("قميص",style:
//                 GoogleFonts.cairo(fontSize:width*0.04,color: appColor ),),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   ),
// ),