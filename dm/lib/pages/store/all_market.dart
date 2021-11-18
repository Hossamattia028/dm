import 'package:dmarketing/models/profile/selller.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/review.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/pages/store/market_info.dart';
import 'package:dmarketing/pages/store/product_details.dart';

class AllMarketPage extends StatefulWidget {
  String kind,title,catID;
  AllMarketPage({this.kind,this.title,this.catID});

  @override
  _AllMarketPageState createState() => _AllMarketPageState();
}

class _AllMarketPageState extends State<AllMarketPage> {
  @override
  void initState() {
    print(widget.title.toString());
    print("market page ");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var categoryProvider = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        centerTitle: true,
        title: Text(
          "${widget.title}",
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
      ),
      body:  Container(
        height: height,
        padding: EdgeInsets.all(3),
        child: widget.kind=="market"?
        FutureBuilder(
          future: widget.catID!=null?
          categoryProvider.getSellers(catID: "${widget.catID}"):
          categoryProvider.getSellers(),
          builder: (context,AsyncSnapshot<List<SellerModel>> snapshot) {
            if (snapshot.data == null) {
              return Center(child: Text(translate("store.no_market",)));
            } else {
              return  snapshot.data.length==0?
              Center(child:Text(translate("store.no_market",),
                style: TextStyle(color: appColor),)):
              ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){

                        Navigator.of(context).push(MaterialPageRoute(builder:
                            (context)=>MarketInfoPage(kind: "market",
                          id: "${snapshot.data[index].id}",
                          name: "${snapshot.data[index].name}",
                          image: "${snapshot.data[index].image}",
                          address: "${snapshot.data[index].address}",
                          phone: "${snapshot.data[index].mobilePhone}",
                        )));
                      },
                      child: Container(
                        width: width,
                        height: height*0.1+20,
                        padding: EdgeInsets.symmetric(horizontal: width*0.04,
                            vertical: height*0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: appColorTwo.withOpacity(0.2)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: height*0.05,
                                  width: width*0.1,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: snapshot.data[index].image==""||snapshot.data[index].image==null?
                                      AssetImage("assets/images/Vatrinty Logo.jpg"):
                                      NetworkImage("${snapshot.data[index].image}"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(width: 1),
                                  ),
                                ),
                                SizedBox(width: width*0.05,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width*0.4+20,
                                      child: Text("${snapshot.data[index].name}",
                                        style: GoogleFonts.cairo(color: Colors.black54,
                                            fontWeight: FontWeight.bold,fontSize: width*0.04),overflow: TextOverflow.ellipsis,),
                                    ),
                                    Text(" 35 "+translate("store.product"),
                                      style: GoogleFonts.cairo(color: appColor,
                                          fontSize: width*0.04),),
                                    reView(140),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_pin,color: appColor,
                                      size: width*0.05,),
                                    Container(
                                      width: width*0.1,
                                      height: height*0.03,
                                      child: Text("${snapshot.data[index].address}",
                                        style: GoogleFonts.cairo(
                                          color: Colors.grey,
                                        ),overflow: TextOverflow.ellipsis,),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: appColor,
                                    ),
                                    padding: EdgeInsets.only(right: 12,left: 12,top: 5,bottom: 5),
                                    child: Text(translate("store.contact"),
                                      style: GoogleFonts.cairo(color: colorWhite,
                                          fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height*0.02,);
                  },
                  itemCount: snapshot.data.length);
            }
          },
        ):
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height*0.8,
              width: width,
              child: FutureBuilder(
                future: categoryProvider.getSellersServices(catID: "${widget.catID}"),
                builder: (context,AsyncSnapshot<List<SellerModel>> snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: Text(translate("store.no_service",),
                      style: TextStyle(color: appColor),));
                  } else {
                    return  snapshot.data.length==0?
                    Center(child:Text(translate("store.no_service",),
                      style: TextStyle(color: appColor),)):
                    ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder:
                                  (context)=>MarketInfoPage(kind: "service",
                                    id: "${snapshot.data[index].id}",
                                    name: "${snapshot.data[index].name}",
                                    image: "${snapshot.data[index].image}",
                                    address: "${snapshot.data[index].address.replaceAll("null", "").toString()}",
                                    phone: "${snapshot.data[index].mobilePhone}",
                                    desc: "${snapshot.data[index].desc}",
                                    jobTitle: "${snapshot.data[index].jobTitle}",
                              )));
                            },
                            child: Container(
                              width: width,
                              height: height*0.1+20,
                              padding: EdgeInsets.symmetric(horizontal: width*0.04,
                                  vertical: height*0.01),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: appColorTwo.withOpacity(0.2)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: height*0.05,
                                        width: width*0.1,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage("${snapshot.data[index].image}"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(width: 1),
                                        ),
                                      ),
                                      SizedBox(width: width*0.05,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${snapshot.data[index].name}",
                                            style: GoogleFonts.cairo(color: Colors.black54,
                                                fontWeight: FontWeight.bold,fontSize: width*0.05),),
                                          Text("${snapshot.data[index].jobTitle}",
                                            style: GoogleFonts.cairo(color: appColor,
                                                fontSize: width*0.04),),
                                          reView(140),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_pin,color: appColor,
                                            size: width*0.05,),
                                          Text("${snapshot.data[index].address.toString().replaceAll("null", "الموقع").toString()}",style: GoogleFonts.cairo(
                                            color: Colors.grey,
                                          ),),
                                        ],
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: appColor,
                                          ),
                                          padding: EdgeInsets.only(right: 12,left: 12,top: 5,bottom: 5),
                                          child: Text(translate("store.contact"),
                                            style: GoogleFonts.cairo(color: colorWhite,
                                                fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: height*0.02,);
                        },
                        itemCount: snapshot.data.length);
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
  int index = 0 ;
}
// Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       onTap: (){
            //         setState(() {
            //           index = 0;
            //         });
            //       },
            //       child: Container(
            //           height: height*0.05,
            //           alignment: Alignment.center,
            //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
            //           ),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color:index==0? appColorTwo:colorWhite,
            //             border: Border.all(width: 1,color: Colors.grey),
            //           ),
            //           child: Text("طبية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
            //               color: index==0?colorWhite:appColor),)
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: (){
            //         setState(() {
            //           index = 1;
            //         });
            //       },
            //       child: Container(
            //           height: height*0.05,
            //           alignment: Alignment.center,
            //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
            //           ),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color:index==1? appColorTwo:colorWhite,
            //             border: Border.all(width: 1,color: Colors.grey),
            //           ),
            //           child: Text("تعليمية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
            //               color: index==1?colorWhite:appColor),)
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: (){
            //         setState(() {
            //           index = 2;
            //         });
            //       },
            //       child: Container(
            //           height: height*0.05,
            //           alignment: Alignment.center,
            //           padding: EdgeInsets.symmetric(horizontal: width*0.08,
            //           ),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color:index==2? appColorTwo:colorWhite,
            //             border: Border.all(width: 1,color: Colors.grey),
            //           ),
            //           child: Text("هندسية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
            //               color: index==2?colorWhite:appColor),)
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: height*0.01,),



// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     GestureDetector(
//       onTap: (){
//         setState(() {
//           index = 0;
//         });
//       },
//       child: Container(
//           height: height*0.05,
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(horizontal: width*0.08,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color:index==0? appColorTwo:colorWhite,
//             border: Border.all(width: 1,color: Colors.grey),
//           ),
//           child: Text("طبية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
//               color: index==0?colorWhite:appColor),)
//       ),
//     ),
//     GestureDetector(
//       onTap: (){
//         setState(() {
//           index = 1;
//         });
//       },
//       child: Container(
//           height: height*0.05,
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(horizontal: width*0.08,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color:index==1? appColorTwo:colorWhite,
//             border: Border.all(width: 1,color: Colors.grey),
//           ),
//           child: Text("تعليمية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
//               color: index==1?colorWhite:appColor),)
//       ),
//     ),
//     GestureDetector(
//       onTap: (){
//         setState(() {
//           index = 2;
//         });
//       },
//       child: Container(
//           height: height*0.05,
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(horizontal: width*0.08,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color:index==2? appColorTwo:colorWhite,
//             border: Border.all(width: 1,color: Colors.grey),
//           ),
//           child: Text("هندسية",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
//               color: index==2?colorWhite:appColor),)
//       ),
//     ),
//   ],
// ),
// SizedBox(height: height*0.01,),