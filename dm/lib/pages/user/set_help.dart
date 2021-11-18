import 'package:dashed_circle/dashed_circle.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';

class SetHelpPage extends StatefulWidget {
  @override
  _SetHelpPageState createState() => _SetHelpPageState();
}

class _SetHelpPageState extends State<SetHelpPage> {
  TextEditingController _searchEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: PreferredSize(
          child: Container(
            height: height*0.2-35,
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).padding.top
            ),
            child: new Padding(
              padding:  EdgeInsets.only(
                  top: height*0.03,
                  right: width*0.04,
                  left: width*0.04,
                  bottom: height*0.02
              ),
              child:  Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(translate("help.help"),
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold, color: colorDark,
                        fontSize: width*0.03+5),
                  ),
                  SizedBox(width: 2,),
                  Card(
                    color: colorWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:Container(
                      padding: EdgeInsets.only(left: 10),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width*0.5,
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
                                  color: appColor,size: width*0.07,),
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

                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: (){},
                      child: Row(
                        children: [
                          Text(translate("store.search_filter"),
                            style: GoogleFonts.cairo(color: appColor,fontSize: width*0.03),),
                          Icon(Icons.filter_list_alt,color: appColor,),
                        ],
                      )
                  ),
                ],
              ),
            ),

          ),
          preferredSize: new Size(
              width,
              110.0
          ),
        ),
        body: Container(
          height: height*0.7+20,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: width*0.02,),
                  DashedCircle(
                    child: Padding(padding: EdgeInsets.all(6.0),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage("assets/images/girl.jpg"),
                      ),
                    ),
                    color: Colors.grey,
                  ),
                  SizedBox(width:width*0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(translate("help.need_help"),style:
                      GoogleFonts.cairo(fontWeight: FontWeight.bold,
                          color: colorDark),),
                      Text(translate("help.add_need_help"),style:
                      GoogleFonts.cairo(fontWeight: FontWeight.bold,
                          color: Colors.black45),),
                    ],
                  )
                ],
              ),
              SizedBox(height: height*0.02+2,),
              Align(
                alignment: Constant.lang=="ar"?
                Alignment.centerRight:Alignment.centerLeft,
                child: Container(
                  color: Colors.grey.withOpacity(0.2),
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: width*0.05),
                  child: Text(translate("help.members_need_help"),style:
                  GoogleFonts.cairo(fontWeight: FontWeight.bold,
                      color: Colors.black54),),
                ),
              ),
              SizedBox(height: height*0.01,),
              Container(
                height: height*0.6-30,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20 * 0.75),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage("assets/icons/help.png"),
                                  ),
                                  // if (index==0)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        height: 16,
                                        width: 16,
                                        decoration: BoxDecoration(
                                          color: appColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              width: 3),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              SizedBox(width: width*0.01,),
                              Expanded(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "name",
                                        style:
                                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                      Opacity(
                                          opacity: 0.64,
                                          child: SizedBox(
                                            width: width*0.6,
                                            child: Text(
                                              index==0?
                                              "i called you please when you open call me at once "
                                                  :"how are you",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: 0.64,
                                child: Text(index==0?"1 am":"20 am"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }, separatorBuilder: (context, index) => SizedBox(height: height*0.01,),
                    itemCount: 20),
              ),
            ],
          )
        )
    );
  }
}
