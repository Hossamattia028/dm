import 'package:dmarketing/helper/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            height: height*0.2-22,
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).padding.top
            ),
            child: new Padding(
              padding:  EdgeInsets.only(
                  top: height*0.02,
                  right: width*0.04,
                  left: width*0.04,
                  bottom: height*0.02,
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("الاشعارات",style: GoogleFonts.cairo(
                    color: colorWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: width*0.05
                  ),),
                  IconButton(
                    icon: Icon(Icons.forward,color: colorWhite,),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      appColor,
                      appColorTwo
                    ]
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(height*0.08),
                  bottomLeft: Radius.circular(height*0.08),
                ),

                boxShadow: [
                  new BoxShadow(
                    color: appColorTwo,
                    blurRadius: 50.0,
                    spreadRadius: 1.0,
                  )
                ]
            ),
          ),
          preferredSize: new Size(
              MediaQuery.of(context).size.width,
              80.0
          ),
        ),
        body: ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => Divider(color: Colors.grey),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(height * 0.02),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: appColor,
                    radius: height * 0.04,
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                  SizedBox(width: width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "عنوان الاشعار ",
                        style: GoogleFonts.cairo(
                          fontSize: width * 0.05,
                        ),
                      ),
                      Text(
                        "تفاصيل .... ",
                        style: GoogleFonts.cairo(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
