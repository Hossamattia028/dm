import 'package:avatar_glow/avatar_glow.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/sliderModel.dart';
import 'package:dmarketing/pages/connection_part/all_status.dart';
import 'package:dmarketing/pages/connection_part/home_chat_list.dart';
import 'package:dmarketing/pages/connection_part/posts_page.dart';
import 'package:dmarketing/pages/connection_part/showing_story.dart';
import 'package:dmarketing/repository/chat/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class MainChatPage extends StatefulWidget {
  @override
  _MainChatPageState createState() => _MainChatPageState();
}

class _MainChatPageState extends State<MainChatPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var storiesProvider = Provider.of<StoriesProvider>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: height*0.06),
      child: Column(
        children: [
          Container(
            width: width ,
            height: height*0.06+4,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical:height*0.01 ),
            color: colorWhite,
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: new TabBar(
                controller: _tabController,
                tabs: [
                  Container(

                    child: Text("جميع المنشورات",
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold),),
                  ),
                  Container(

                    child: Text("محادثات",
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold),),
                  ),
                ],
                isScrollable: true,
                indicatorColor: appColor,
                labelColor: appColor,
                unselectedLabelColor:Colors.black54 ,
                unselectedLabelStyle:
                TextStyle(color: colorDark, fontSize: width*0.04),
                // labelStyle: TextStyle(color: colorDark, fontSize: 18),
                // labelPadding: EdgeInsets.only(left: 4.5,right: 4.5),
              ),
            ),
          ),
          SizedBox(height: height*0.02,),
          Container(
            height: height+100,
            width: width,
            color: appColor,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                AllPostsPage(),
                HomeChatListPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
