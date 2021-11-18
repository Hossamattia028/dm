import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dmarketing/helper/showtoast.dart';

class CustomerChatList extends StatefulWidget {
  const CustomerChatList({Key key}) : super(key: key);

  @override
  _CustomerChatListState createState() => _CustomerChatListState();
}

class _CustomerChatListState extends State<CustomerChatList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: height*0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
                color: colorWhite,
                margin: EdgeInsets.symmetric(horizontal: width*0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: appColor,width: 1)
                ),
                child:Container(
                  width: width ,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 5,),
                  child: TextField(
                    autocorrect: true,
                    controller: _searchEditingController,
                    decoration: InputDecoration(
                      hintText: translate("home.search"),
                      counterStyle: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold
                      ),
                      prefixIcon: Icon(Icons.search_rounded,
                        color: Colors.grey,size: width*0.06,),
                      hintStyle: TextStyle(color: Colors.black45),
                      filled: true,
                      fillColor: colorWhite,
                      contentPadding: EdgeInsets.only(top: 0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: colorWhite, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: colorWhite, width: 2),
                      ),
                    ),
                    onSubmitted: (_){

                    },
                  ),
                ),
            ),
            SizedBox(height: height*0.03,),
            Container(
                alignment: Alignment.topCenter,
                width:width,
                height: height*0.5+10,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            color: appColorTwo.withOpacity(0.2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height*0.06,
                                      width: width*0.1+10,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/chatperson"),
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
                                        Text("هالة احمد",
                                          style: GoogleFonts.cairo(color: appColor,
                                              fontWeight: FontWeight.bold,fontSize: width*0.05),),
                                        Text(" رسالة ..",style: GoogleFonts.cairo(color: Colors.black54,
                                            fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ],
                                ),
                                Text("24 ابريل 2021",style: GoogleFonts.cairo(color: Colors.black54,
                                fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                      );
                    }, separatorBuilder: (context, index) {
                  return SizedBox(height: height*0.02,);
                }, itemCount: 10)
            ),
          ],
        ),
      ),
    );
  }
  TextEditingController _searchEditingController = new TextEditingController();

}
