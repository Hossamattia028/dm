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

class MarketViewProductDetailsPage extends StatefulWidget {
  String id,productName,price,price_after_discount,description,sallerPhone,productImage;
  List<SliderModel> images;
  bool fav;
  MarketViewProductDetailsPage({
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
  _MarketViewProductDetailsPageState createState() => _MarketViewProductDetailsPageState();
}

class _MarketViewProductDetailsPageState extends State<MarketViewProductDetailsPage> {
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
          "${widget.productName}",
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.edit,color: appColor,),
          )
        ],
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
                        Row(
                          children: [
                            Image.asset("assets/images/Group 888.png",
                              width: width*0.2,height: height*0.06-2,fit: BoxFit.contain,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.price_after_discount}${translate("store.bound")}",
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

                      ],
                    ),
                    SizedBox(height: height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translate("store.size"),
                          style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                              fontSize: width*0.05,color: Colors.black54),),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: Text("S",style:GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                  fontSize: width*0.06,color: appColor) ,),
                            ),
                            SizedBox(width: width*0.02,),
                            Container(
                              decoration: BoxDecoration(),
                              child: Text("M",style:GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                  fontSize: width*0.06,color: appColor) ,),
                            ),
                            SizedBox(width: width*0.02,),
                            Container(
                              width: width*0.1,
                              height: height*0.06,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2,color: appColor),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text("XI",style:GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                  fontSize: width*0.06,color: Colors.black),textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(height: height*0.01,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text("??????????????",
                    //       style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                    //           fontSize: width*0.05,color: Colors.black54),),
                    //
                    //   ],
                    // ),
                    SizedBox(height: height*0.02,),
                    Text(translate("store.description"),
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                          fontSize: width*0.05,color: appColor),),
                    Html(data:
                    "${widget.description}"
                      ,),
                    SizedBox(height: height*0.02,),
                    Text("??????????????????",
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
                                        Text("???????? ???????? ......",style: GoogleFonts.cairo(
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

          ],
        ),
      ),
    );
  }
}
