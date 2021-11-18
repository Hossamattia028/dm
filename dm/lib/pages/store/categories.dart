import 'package:dmarketing/models/profile/selller.dart';
import 'package:dmarketing/models/store/Categories.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/review.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/pages/store/all_market.dart';
import 'package:dmarketing/pages/store/all_products.dart';
import 'package:dmarketing/pages/store/market_info.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  String kindCategory,catID,categoryName;
  bool productsPage;
  CategoriesPage({this.kindCategory,this.catID,this.categoryName,this.productsPage});
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}
class _CategoriesPageState extends State<CategoriesPage> {
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
    var categoriesProvider = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName=="all"?translate("categories"):
          "${widget.categoryName}",
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
      body:  widget.kindCategory!="market" && widget.productsPage==true?
      FutureBuilder(
        future: categoriesProvider.getSellersServices(catID: "${widget.catID}"),
        builder: (context,AsyncSnapshot<List<SellerModel>> snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
          } else {
            return  snapshot.data.length==0?
            Center(child:Text(translate("toast.home_no_product",),
              style: TextStyle(color: appColor),)):
            Container(
              height: height,
              padding: EdgeInsets.all(2),
              child: ListView.separated(
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
                  itemCount: snapshot.data.length),
            );
          }
        },
      ):
      FutureBuilder(
          future: widget.productsPage==true?
          categoriesProvider.getSubCategories("${widget.catID}"):
          categoriesProvider.getCategories(home: true,asMarket: widget.kindCategory=="market"?
          true:false),
          builder: (context,AsyncSnapshot<List<Categories>> snapshots) {
            if (snapshots.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return snapshots.data.length==0?
              Center(child:Text(translate("toast.home_no_product",),
                style: TextStyle(color: appColor),)):
               Container(
                alignment: Alignment.topCenter,
                width:width,
                height: height,
                color: colorWhite,
                padding: EdgeInsets.all(5),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  controller: myScrollController,
                  padding: EdgeInsets.zero,
                  itemCount: snapshots.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(widget.kindCategory.toString());
                        if(widget.productsPage==true){
                          Navigator.of(context).push(MaterialPageRoute(builder:
                              (context)=>AllMarketPage(
                                 kind: "${widget.kindCategory}",
                                 title:"${snapshots.data[index].name}" ,
                                 catID:"${snapshots.data[index].id}" ,
                          )));
                        }else{
                          Navigator.of(context).push(MaterialPageRoute(builder:
                              (context)=>CategoriesPage(
                            categoryName:"${snapshots.data[index].name}" ,
                            kindCategory: "${widget.kindCategory}",
                            catID: "${snapshots.data[index].id}" ,
                            productsPage: true,
                          )));
                        }

                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height*0.1-5,
                              width: width*0.2+10,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: appColor),
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey[100],
                                image: DecorationImage(
                                    image: NetworkImage(
                                      '${snapshots.data[index].image}',
                                    ),
                                    fit: BoxFit.cover
                                ),
                              ),
                              padding: EdgeInsets.all(0),
                            ),
                            SizedBox(height: height*0.02,),
                            Container(
                              width: width*0.3,
                              alignment: Alignment.center,
                              child: Text("${snapshots.data[index].name}",
                                style: GoogleFonts.cairo(color:colorDark,
                                    fontWeight: FontWeight.bold,fontSize: width*0.04-1),
                                overflow: TextOverflow.ellipsis,),
                            ),
                          ],
                        ),
                      )
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
