import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/chat_model.dart';
import 'package:dmarketing/models/profile/UserData.dart';
import 'package:dmarketing/pages/connection_part/chat/chatFirestore.dart';
import 'package:dmarketing/repository/chat/chat_firestore.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomersListPage extends StatefulWidget {
  @override
  _CustomersListPageState createState() => _CustomersListPageState();
}

class _CustomersListPageState extends State<CustomersListPage> {
  TextEditingController _searchEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);
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
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined),
                  color: appColor,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
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
              ],
            ),
          ),

        ),
        preferredSize: new Size(
            width,
            110.0
        ),
      ),
      body: FutureBuilder(
          future: categoryProvider.getAllCustomers(),
          builder: (context,AsyncSnapshot<List<UserData>> snapshot) {
            return snapshot.hasData
                ? ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if(snapshot.data[index].username.toString().trim().
                  contains(_searchEditingController.text.toString().trim())){
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            ChatPage(
                                chatRoomId: "${Constant.id}_${snapshot.data[index].authid}",
                                friend_id: "${snapshot.data[index].authid}",
                                friend_name: "${snapshot.data[index].username}"
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
                                  backgroundImage: NetworkImage("${snapshot.data[index].image}"),
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
                                      "${snapshot.data[index].username}",
                                      style:
                                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    Opacity(
                                        opacity: 0.64,
                                        child: SizedBox(
                                          width: width*0.6,
                                          child: Text(
                                            "${snapshot.data[index].email}",
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

                          ],
                        ),
                      ),
                    );
                  }else{
                    return Container();
                  }

                }, separatorBuilder: (context, index) => SizedBox(height: height*0.01,),
                itemCount:snapshot.data.length)
                : Container(
              child: Text(translate("store.no_data")),
            );
          },
        ),
    );
  }


}
