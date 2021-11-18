import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/chat_model.dart';
import 'package:dmarketing/pages/connection_part/all_customers.dart';
import 'package:dmarketing/pages/connection_part/chat/chatFirestore.dart';
import 'package:dmarketing/repository/chat/chat_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeChatListPage extends StatefulWidget {
  @override
  _HomeChatListPageState createState() => _HomeChatListPageState();
}

class _HomeChatListPageState extends State<HomeChatListPage> {
  TextEditingController _searchEditingController = new TextEditingController();
  bool seenornot = false;
  Stream chatRooms;
  @override
  void initState() {
    getUserChats();
    super.initState();
  }
  getUserChats() async {
    await DatabaseMethods().getUserChats("${Constant.id}").then((snapshots) {
      setState(() {
        chatRooms = snapshots;
      });
    });
  }
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
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(translate("app_bar.name_chat"),
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold, color: colorDark,
                        fontSize: width*0.04),
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
                            width: width*0.6,
                            padding: EdgeInsets.only(right: 5,),
                            child: TextField(

                              controller: _searchEditingController,
                              decoration: InputDecoration(
                                hintText: translate("home.search"),
                                counterStyle: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold
                                ),
                                prefixIcon: Icon(Icons.search_rounded,
                                  color: appColor,size: width*0.07,),
                                hintStyle: TextStyle(color: Colors.black45),

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
                              onChanged: (val){
                                  setState(() {
                                    _searchEditingController.text=val;
                                  });
                              },
                              onSubmitted: (val){
                                  setState(() {
                                    _searchEditingController.text=val;
                                  });
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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width*0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RaisedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (context)=>CustomersListPage()));
              },
                child: Text(translate("chat.all_customers"),style: GoogleFonts.cairo(
                  color: colorWhite,fontWeight: FontWeight.bold,
                ),),
                color: appColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                height: height*0.7,
                child: StreamBuilder(
                  stream: chatRooms,
                  builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            String dateAgo = "";
                            if(DateTime.now().difference(DateTime.parse(
                                snapshot.data.documents[index].data()['date'].toString())).inDays.toString()!="0"){
                              dateAgo = dateAgo +" "+DateTime.now().difference(DateTime.parse(
                                  snapshot.data.documents[index].data()['date'].toString())).inDays.toString()+"d";
                            }else if (DateTime.now().difference(DateTime.parse(
                                snapshot.data.documents[index].data()['date'].toString())).inHours.toString()!="0"){
                              dateAgo = dateAgo +" "+DateTime.now().difference(DateTime.parse(
                                  snapshot.data.documents[index].data()['date'].toString())).inHours.toString()+"h";
                            }else if (DateTime.now().difference(DateTime.parse(
                                snapshot.data.documents[index].data()['date'].toString())).inMinutes.toString()!="0"){
                              dateAgo = dateAgo +" "+DateTime.now().difference(DateTime.parse(
                                  snapshot.data.documents[index].data()['date'].toString())).inMinutes.toString()+"m";
                            }else{
                              dateAgo = dateAgo +" "+DateTime.now().difference(DateTime.parse(
                                  snapshot.data.documents[index].data()['date'].toString())).inSeconds.toString()+"s";
                            }
                            if(snapshot.data.documents[index].data()['friendName'].toString().trim()
                                .contains("${_searchEditingController.text.toString().trim()}")||
                                _searchEditingController.text.toString().trim()==snapshot.data.documents[index].data()['friendName'].toString().trim()){
                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                      ChatPage(chatRoomId: "${snapshot.data.documents[index].data()['chatRoomId'].toString()}",
                                        friend_id: "${snapshot.data.documents[index].data()['friendID'].toString()}",
                                        friend_name: "${snapshot.data.documents[index].data()['friendName'].toString()}",
                                      )));
                                },
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
                                            backgroundImage: AssetImage("assets/images/girl.jpg"),
                                          ),
                                          if (index==0)
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
                                                "${snapshot.data.documents[index].data()['friendName'].toString()}",
                                                style:
                                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                              ),
                                              Opacity(
                                                  opacity: 0.64,
                                                  child: SizedBox(
                                                    width: width*0.6,
                                                    child: Text(
                                                      ".....",
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
                                        child: Row(
                                          children: [
                                            Text("${translate("chat.ago")}"),
                                            SizedBox(width: width*0.02,),
                                            Text("$dateAgo"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }else{
                              return Container();
                            }
                          }, separatorBuilder: (context, index) => SizedBox(height: height*0.01,),
                          itemCount:snapshot.data.documents.length)
                          : Center(
                        child: Text(translate("store.no_data")),
                      );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }


}
