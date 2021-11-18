import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dmarketing/elements/review.dart';
import 'package:dmarketing/helper/customLaunch.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/pages/store/all_products.dart';

class MarketInfoPage extends StatefulWidget {
   String kind,id,name,image,address,phone,desc,jobTitle;
   MarketInfoPage({this.kind,this.id,this.name,this.image,this.address,
     this.phone,this.desc,this.jobTitle});

  @override
  _MarketInfoPageState createState() => _MarketInfoPageState();
}

class _MarketInfoPageState extends State<MarketInfoPage> {
  @override
  void initState() {
    print("image: "+widget.image.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        centerTitle: true,
        title: Text(
          "${widget.name}",
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width*0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width*0.2+4,
              height: height*0.1,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: appColor,width: 2),
                  color: colorWhite
              ),
              child: widget.image.toString()=="null"||
                  widget.image.toString()=="https://dev.matrixclouds.com/fatarnati/public/"?
                  Image.asset("assets/images/logooo.png",height: height*0.05,
                    width: width*0.2,alignment: Alignment.center,
                    fit: BoxFit.cover,):
              Image.network("${widget.image}",height: height*0.05,
                width: width*0.2,alignment: Alignment.center,
                fit: BoxFit.cover,),
            ),
            Text("${widget.name}",
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                fontSize: width*0.05,color: appColor,),),
            // Text("ملابس منوعة",
            //   style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
            //     fontSize: width*0.04-1,color: Colors.black45,),),
            widget.kind!="market"?reView(200):
            SizedBox(),
            Text("${widget.jobTitle.toString().replaceAll("null", "").toString()}",
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                fontSize: width*0.04-1,color: Colors.black45,),
              textAlign: TextAlign.center,),
            Text("${widget.address.toString().replaceAll("null", "").toString()}",
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                fontSize: width*0.04-1,color: Colors.black45,),
              textAlign: TextAlign.center,),
            SizedBox(height: height*0.02,),
            widget.kind=="market"?
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (context)=>AllProducts(kind: "${widget.kind}",
                      marketName: "${widget.name}",
                      marketID: "${widget.id}",
                    )));
              },
              child: Container(
                width: width*0.5-20,
                height: height*0.05,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: appColor
                ),
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Text(widget.kind=="market"?
                translate("store.view_products"):
                translate("store.view_service"),
                  style: GoogleFonts.cairo(color: colorWhite,
                      fontWeight: FontWeight.bold,fontSize: width*0.04+2),),
              ),
            ):
            Column(
             children: [
               Align(
                 alignment: Alignment.centerRight,
                 child: Text(translate("store.description"),
                   style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                     fontSize: width*0.04+5,color: appColor,),),
               ),
               Text("${widget.desc.toString().replaceAll("null", "").toString()}",style: GoogleFonts.cairo(
                 fontWeight: FontWeight.bold,
                 color: Colors.black38
               ),),
             ],
            ),
            SizedBox(height: height*0.04,),
            Align(
              alignment: Alignment.centerRight,
              child: Text(translate("store.contact"),
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                  fontSize: width*0.04+5,color: appColor,),),
            ),
            SizedBox(height: height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                smallWidget(height, width, "whatsapp.png", "اتصال",iconData: Icons.call,img: "Group 1141.png"),
                smallWidget(height, width, "messenger.png",  translate("about.messanger"),img: "unnamed.png"),
                SizedBox(width: width*0.01,),
                smallWidget(height, width, "whatsapp.png",  translate("about.whatsapp"),img: "whatsapp.png"),
                smallWidget(height, width, "whatsapp.png", translate("about.chat"),iconData: Icons.chat,img: "Group 1142.png"),
                smallWidget(height, width, "whatsapp.png", "لوكيشن",iconData: Icons.location_pin,img: "Group 1143.png"),
              ],
            ),
            SizedBox(height: height*0.02,),
            Divider(
              thickness: 3,
            ),
            SizedBox(height: height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                smallWidget(height, width, "virus.png", "ابلاغ",img:"Group 1144.png"),
                smallWidget(height, width, "whatsapp.png", "تقييم",img: "Group 1145.png"),
                // smallWidget(height, width, "whatsapp.png", "خصومات",img: "sale-tag.png"),
              ],
            ),

          ],
        ),
      ),
    );
  }
  Widget smallWidget(double height,double width,String imgPath,
      String title, {IconData iconData,String img}){
    // if(img!=null){
      return GestureDetector(
        child: Container(
          width: width*0.2-6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                ),
                padding: EdgeInsets.all(0),
                child: img=="Group 1145.png"||img=="Group 1144.png"?
                Image.asset("assets/images/$img",
                  height:height*0.08+2,width: width*0.2,
                  fit: BoxFit.cover,):
                Image.asset("assets/images/$img",
                  height:height*0.05+2,width: width*0.1,
                  fit: BoxFit.fitWidth,),
              ),
              SizedBox(height: height*0.01,),
              Text("$title",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                fontSize: width*0.04,color: Colors.black45,),)
            ],
          ),
        ),
      );
    // }else{
    //   return iconData==null?
    //   GestureDetector(
    //     onTap: (){
    //       if(imgPath=="whatsapp.png"){
    //         customLaunch("https://wa.me/${widget.phone}?text=dmarketing");
    //       }
    //     },
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Image.asset("assets/images/$imgPath",height:imgPath=="whatsapp.png"?height*0.06+1:height*0.05,width: imgPath=="whatsapp.png"?
    //         width*0.1+10:width*0.1+5,
    //           fit: BoxFit.cover,),
    //         SizedBox(height: height*0.02,),
    //         Text("$title",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
    //           fontSize: width*0.04-1,color: Colors.black45,),)
    //       ],
    //     ),
    //   ):
    //   GestureDetector(
    //     onTap: (){
    //       if(iconData==Icons.call){
    //         customLaunch("tel:${widget.phone}");
    //       }
    //     },
    //     child: Container(
    //       width: width*0.2-10,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(100),
    //                 color: appColorTwo
    //             ),
    //             padding: EdgeInsets.all(10),
    //             child: Icon(iconData,color: colorWhite,),
    //           ),
    //           SizedBox(height: height*0.02,),
    //           Text("$title",style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
    //             fontSize: width*0.04-1,color: Colors.black45,),)
    //         ],
    //       ),
    //     ),
    //   );
    // }

  }
}
