// import 'package:dmarketing/models/store/Orders.dart';
// import 'package:dmarketing/repository/store/order.dart';
// import 'package:flutter/material.dart';
// import 'package:dmarketing/helper/showtoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_translate/global.dart';
//
//
// class UserOrdersPage extends StatefulWidget {
//   const UserOrdersPage({Key key}) : super(key: key);
//
//   @override
//   _UserOrdersPageState createState() => _UserOrdersPageState();
// }
//
// class _UserOrdersPageState extends State<UserOrdersPage> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     var orderProvider = Provider.of<Order>(context);
//     return Scaffold(
//       backgroundColor: colorWhite,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         iconTheme: IconThemeData(color: appColor),
//         title: Text(
//           translate("navigation_bar.order"),
//           style: GoogleFonts.cairo(
//             color: appColor,
//           ),
//         ),
//       ),
//       body:
//       FutureBuilder(
//           future: orderProvider.getOrders(),
//           builder: (context, AsyncSnapshot<List<OrdersModel>> snapshots) {
//             if (snapshots.data == null) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               return snapshots.data==null ||snapshots.data.length==0?
//               Center(child:Text(translate("myorder.empty",),
//                 style: TextStyle(color: appColor),))
//                   : Container(
//                 height: height,
//                 width: width,
//                 padding: EdgeInsets.all(5),
//                 child:ListView.separated(
//                     scrollDirection: Axis.vertical,
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return Card(
//                         color: colorWhite,
//                         child: Container(
//                           width: width-67,
//                           padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
//                           child:Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text("${snapshots.data[index].name}",
//                                     style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
//                                         fontSize: width*0.05,color: appColor),),
//                                   SizedBox(width: width*0.02,),
//                                   Row(
//                                     children: [
//                                       Text("العدد",
//                                         style: GoogleFonts.cairo(
//                                             fontWeight: FontWeight.bold,color: Colors.black54),),
//                                       SizedBox(width: width*0.01,),
//                                       Text("1", style: GoogleFonts.cairo(
//                                           fontWeight: FontWeight.bold,color: Colors.black54)),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Text("${snapshots.data[index].price}${translate("store.bound")}",style: GoogleFonts.cairo(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,fontSize: width*0.05
//                               ),),
//                               Text("${snapshots.data[index].date}",style: GoogleFonts.cairo(
//                                   fontWeight: FontWeight.bold,
//                                   color: appColor,fontSize: width*0.04
//                               ),),
//
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(translate("myorder.status"),
//                                         style: GoogleFonts.cairo(
//                                             fontWeight: FontWeight.bold,color: Colors.black54),),
//                                       SizedBox(width: width*0.01,),
//                                       Text("تم الشحن", style: GoogleFonts.cairo(
//                                           fontWeight: FontWeight.bold,color: Colors.black54)),
//                                     ],
//                                   ),
//
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: GestureDetector(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(20),
//                                             color: appColor
//                                         ),
//                                         padding: EdgeInsets.only(left: 15,right: 15),
//                                         child: Text("التفاصيل",
//                                           style: GoogleFonts.cairo(color: colorWhite),),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//
//
//                               SizedBox(height: 1,),
//
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return SizedBox(width: width*0.03,);
//                     }, itemCount: snapshots.data.length),
//               );
//             }
//           })
//
//
//     );
//   }
// }
