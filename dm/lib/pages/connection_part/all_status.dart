import 'package:avatar_glow/avatar_glow.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/sliderModel.dart';
import 'package:dmarketing/pages/connection_part/showing_story.dart';
import 'package:dmarketing/repository/chat/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllStatusPages extends StatefulWidget {
  @override
  _AllStatusPagesState createState() => _AllStatusPagesState();
}

class _AllStatusPagesState extends State<AllStatusPages> {
  ScrollController myScrollController ;
  @override
  void initState() {
    myScrollController = ScrollController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var storiesProvider = Provider.of<StoriesProvider>(context);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: appColor),
        title: Text(
          translate("chat.status"),
          style: GoogleFonts.cairo(
            color: colorDark,fontWeight: FontWeight.bold
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: (){},
            child: Image.asset("assets/icons/add_story.png",
              height: height*0.02,width: width*0.09,),
          ),
          SizedBox(width: width*0.05,),
          GestureDetector(
            onTap: (){},
            child: Image.asset("assets/icons/option_story.png",
              height: height*0.01,width: width*0.06,),
          ),
          GestureDetector(
            onTap: (){
            },
            child: Row(
              children: [
                SizedBox(width: width*0.06,),
                Image.asset("assets/icons/pointA.png",
                  height: height*0.03,width: width*0.02,),
              ],
            )
          ),
          SizedBox(width: width*0.04,),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: height*0.02,left: width*0.05,
        right: width*0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               children: [
                 Stack(
                   children: [
                     AvatarGlow(
                       glowColor: appColor,
                       endRadius: 40.0,
                       duration: Duration(milliseconds: 3000),
                       repeat: true,
                       showTwoGlows: true,
                       repeatPauseDuration: Duration(milliseconds: 20),
                       child: Material(     // Replace this child with your own
                         elevation: 8.0,
                         shape: CircleBorder(),
                         child: CircleAvatar(
                           radius: 25,
                           backgroundImage: AssetImage("assets/images/girl.jpg"),
                         ),
                       ),
                     ),
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
                       ),
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
                                 "Your status is active",
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             )
                         ),

                       ],
                     ),
                   ),
                 ),
               ],
            ),
            SizedBox(height: height*0.02,),
            Text(
              translate("chat.all_status"),
              style:
              GoogleFonts.cairo(fontSize: width*0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height*0.02,),
            Container(
              alignment: Alignment.topCenter,
              width:width,
              height: height,
              color: colorWhite,
              padding: EdgeInsets.all(2),
              child:  FutureBuilder(
                future: storiesProvider.getStories(),
                builder: (context,AsyncSnapshot<List<SliderModel>> snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
                  } else {
                    return  snapshot.data.length==0?
                    Center(child:Text(translate("store.no_data",),
                      style: TextStyle(color: appColor),)):
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: height*0.02,
                        mainAxisSpacing: height*0.02,
                      ),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      controller: myScrollController,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder:
                                  (context)=>StoryDetails(
                                    id: "${snapshot.data[index].id}",
                                    title: "${snapshot.data[index].name}",
                                    content: "${snapshot.data[index].description}",
                                    image: "${snapshot.data[index].image}",
                                  )));
                            },
                            child: Stack(
                              children: [
                                // AvatarGlow(
                                //   glowColor: appColor,
                                //   endRadius: 40.0,
                                //   duration: Duration(milliseconds: 3000),
                                //   repeat: true,
                                //   showTwoGlows: true,
                                //   repeatPauseDuration: Duration(milliseconds: 20),
                                //   child: Material(     // Replace this child with your own
                                //     elevation: 8.0,
                                //     shape: CircleBorder(),
                                //     child: CircleAvatar(
                                //       radius: 30,
                                //       backgroundImage: NetworkImage("${snapshot.data[index].image}"),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2,color: appColor.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:EdgeInsets.all(10),
                                  child:  AvatarGlow(
                                    glowColor: appColor,
                                    endRadius: 40.0,
                                    duration: Duration(milliseconds: 3000),
                                    repeat: true,
                                    showTwoGlows: true,
                                    repeatPauseDuration: Duration(milliseconds: 20),
                                    child: Material(     // Replace this child with your own
                                      elevation: 8.0,
                                      shape: CircleBorder(),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage("${snapshot.data[index].image}"),
                                      ),
                                    ),
                                  ),
                                  // Image.network("${snapshot.data[index].image}",
                                  //   fit: BoxFit.contain,
                                  //   alignment: Alignment.center,),
                                ),

                              ],
                            )
                        );
                      },
                    );
                  }
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
