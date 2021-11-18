import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:dmarketing/repository/store/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/fullView.dart';
import 'package:dmarketing/elements/review.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/sliderModel.dart';
import 'package:dmarketing/pages/signing/login_screen.dart';
import 'package:dmarketing/root_pages.dart';

class ProductDetailsPage extends StatefulWidget {
  String id,productName,price,price_after_discount,description,sallerPhone,productImage;
  List<SliderModel> images;
  bool fav;
  ProductDetailsPage({
    this.id,
    this.productName,
    this.price,
    this.images,
    this.price_after_discount,
    this.description,
    this.fav,this.sallerPhone,
    this.productImage
    });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  SwiperController _swiperController;
  @override
  void initState() {
    _swiperController = SwiperController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var favProvider = Provider.of<FavAndCart>(context,listen: false);
    // var orderProvider = Provider.of<Order>(context,listen: false);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        centerTitle: true,
        title: Text(
          "${widget.productName}",
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [

                Container(
                  height: height*0.2,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.images!=null?
                        "${widget.images.first.image}":"${widget.productImage}"),
                        fit:BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Container(
                  height: height*0.06,
                  width: width*0.1+5,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(widget.fav==true?
                    Icons.favorite:
                    Icons.favorite_border,color: appColor,),
                    onPressed: ()async{
                      if(Constant.id != null){
                        setState(() {
                          widget.fav = !widget.fav;
                        });
                        if(widget.fav==true){
                          showToast(translate("toast.favourite"));
                          await favProvider.addToFavourite(productID: "${widget.id}").then((value) {
                            Navigator.of(context).push(MaterialPageRoute(builder:
                                (context)=>RootPages(checkPage: "1",)));
                          });
                        }else{
                          await favProvider.removeFromFavourite(ID: "${widget.id}").then((value) {
                            if(value.toString()=="yes"){
                              showToast(translate("toast.dis_favourite"));
                            }
                          });
                        }
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder:
                            (context)=> LoginScreen()));
                      }

                    },
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            widget.images!=null?Container(
              height: height * 0.1,
              width: width*0.8,
              margin: EdgeInsets.zero,
                child:  Swiper(
                  controller: _swiperController,
                  autoplay: true,
                  autoplayDisableOnInteraction: false,
                  itemBuilder: (BuildContext context, int index) {
                    // print(index);
                    print(widget.images.length.toString());
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                           onTap: (){
                             fullView(context, "${widget.images[index].image}");
                           },
                           child: SizedBox(
                             height: height * 0.1,
                             width: width*0.2,
                             child: CachedNetworkImage(
                               fit: BoxFit.cover,
                               imageUrl:
                               "${widget.images[index].image}",
                               placeholder: (context, url) => Image.asset(
                                 'assets/images/loading.gif',
                                 fit: BoxFit.cover,
                               ),
                               errorWidget: (context, url, error) =>
                                   Icon(Icons.error),
                             ),
                           ),
                        ),
                        SizedBox(width: width*0.04,),
                        index!=null&&index!=widget.images.length-1&&
                        widget.images[index+1].image!=null?
                        GestureDetector(
                          onTap: (){
                            fullView(context,"${widget.images[index+1].image}");
                          },
                          child: SizedBox(
                              height: height * 0.1,
                              width: width*0.2,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                "${widget.images[index+1].image}",
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                          ),
                        ):SizedBox(),
                      ],
                    );
                  },
                  itemCount: widget.images.length,
                  pagination:
                  new SwiperPagination(alignment: Alignment.bottomLeft,),
                  control: new SwiperControl(
                      color: Colors.grey,
                      size: width*0.07-1
                  ),
                  physics: BouncingScrollPhysics(),

                )
            ):SizedBox(),
            Container(
             margin: EdgeInsets.only(left: width*0.04,right:width*0.04 ),
             child:  Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(height: height*0.02,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("${widget.productName}",
                           style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                               fontSize: width*0.05,color: Colors.black),),
                         SizedBox(height: height*0.01,),
                         reView(200),
                       ],
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("${widget.price}${translate("store.bound")}",
                           style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                               fontSize: width*0.05,color: appColor),),
                         Text("${widget.price}${translate("store.bound")}",
                           style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                               fontSize: width*0.04,color: Colors.grey,
                               decoration:TextDecoration.lineThrough),),
                       ],
                     ),
                   ],
                 ),

                 SizedBox(height: height*0.02,),
                 Text(translate("store.description"),
                   style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                       fontSize: width*0.05,color: appColor),),
                 Html(data:
                 "${widget.description}"
                   ,),
                 SizedBox(height: height*0.02,),
                 Text("التقييمات",
                   style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                       fontSize: width*0.05,color: appColor),),
                 Container(
                   height: height*0.2+20,
                   width: width,
                   child:ListView.separated(
                       scrollDirection: Axis.vertical,
                       physics: BouncingScrollPhysics(),
                       itemBuilder: (context, index) {
                         return GestureDetector(
                           onTap: (){

                           },
                           child: Container(
                             width: width-67,
                             padding: EdgeInsets.all(10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Container(
                                   height: height*0.06,width: width*0.1+10,
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: appColor,
                                   ),
                                   child: Text("N", style: GoogleFonts.cairo(decoration: TextDecoration.lineThrough,
                                       fontWeight: FontWeight.bold,color: colorWhite,
                                       fontSize: width*0.05),),
                                 ),
                                 SizedBox(width: width*0.05,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Nada Ahmed ",
                                           style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                               fontSize: width*0.05,color: Colors.black54),),
                                         reView(200),
                                       ],
                                     ),
                                     Text("منتج مميز ......",style: GoogleFonts.cairo(
                                         fontWeight: FontWeight.bold,
                                         color: Colors.grey,fontSize: width*0.03
                                     ),),


                                     SizedBox(height: height*0.01,),


                                   ],
                                 ),
                               ],
                             ),
                           ),
                         );
                       },
                       separatorBuilder: (context, index) {
                         return SizedBox(width: width*0.03,);
                       }, itemCount: 2),
                 ),
               ],
             )
           ),
            // GestureDetector(
            //   onTap: ()async{
            //     await orderProvider.saveOrder(context: context,product_id: "${widget.id}");
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: appColor
            //     ),
            //     padding: EdgeInsets.only(left: width*0.2,right: width*0.2),
            //     child: Text(translate("store.order_request"),
            //       style: GoogleFonts.cairo(color: colorWhite,
            //       fontSize: width*0.05),),
            //   ),
            // ),

            GestureDetector(
              onTap: (){
                customLaunch("tel:${widget.sallerPhone}");
              },
              child: Container(
                width: width*0.2,
                alignment: Alignment.center,
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
      ),
    );
  }
}
