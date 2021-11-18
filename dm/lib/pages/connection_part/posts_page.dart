import 'package:avatar_glow/avatar_glow.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/sliderModel.dart';
import 'package:dmarketing/pages/connection_part/showing_story.dart';
import 'package:dmarketing/repository/chat/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fb_news/flutter_fb_news.dart';
import 'package:flutter_fb_news/flutter_fb_news_config.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllPostsPage extends StatefulWidget {
  @override
  _AllPostsPageState createState() => _AllPostsPageState();
}

class _AllPostsPageState extends State<AllPostsPage> {
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
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: appColor),
      //   title: Text(
      //     translate("app_bar.name"),
      //     style: GoogleFonts.cairo(
      //         color: colorDark,fontWeight: FontWeight.bold
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      //   actions: [
      //
      //   ],
      // ),
      body:FutureBuilder(
        future: storiesProvider.getStories(),
        builder: (context,AsyncSnapshot<List<SliderModel>> snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator(backgroundColor: appColor,));
          } else {
            return  snapshot.data.length==0?
            Center(child:Text(translate("store.no_data",),
              style: TextStyle(color: appColor),)):
            ListView.separated(
                physics: BouncingScrollPhysics(),
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
                    child: Card(
                      elevation: 5,
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: width*0.01,),
                              CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/girl.jpg"
                                  )
                              ),
                              SizedBox(width: width*0.03,),
                              Text("User name ",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,color: appColor,
                              fontSize: width*0.05-2),),
                            ],
                          ),
                          SizedBox(height: height*0.01,),
                          Text("  content of Post..........",style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,color: appColor),),
                          SizedBox(height: height*0.01,),
                          Divider(thickness: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(onPressed: (){},
                                  icon: Icon(index==0?Icons.favorite:
                                  Icons.favorite_border,color: Colors.red,)),
                              IconButton(onPressed: (){},
                                  icon: Icon(Icons.chat_bubble,color:appColor,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder:(context, index) => SizedBox(),
                itemCount: 10);
          }
        },
      ),
    );
  }
}
