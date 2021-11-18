import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/repository/chat/chat_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  String friend_id,friend_name,chatRoomId;
  ChatPage({this.friend_id,this.friend_name,this.chatRoomId});
  @override
  _ChatState createState() => _ChatState();
}
List<int> listunseen=[];
class _ChatState extends State<ChatPage> {
  String order_id = "";
  int listLength=0;
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  Widget chatMessages(){
    setState(() {
      listunseen.clear();
    });
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
          itemCount: snapshot.data.documents.length,
            reverse: true,
            itemBuilder: (context, index){

              return MessageTile(
                message: snapshot.data.documents[index].data()["message"].toString(),
                sendByMe: Constant.id == snapshot.data.documents[index].data()["sendBy"],
                timeshow:Constant.lang.toString() =="ar" ?
                snapshot.data.documents[index].data()["timeshow"].toString().replaceAll("ص", "AM").replaceAll("م", "PM"):
                snapshot.data.documents[index].data()["timeshow"].toString().replaceAll("AM", "ص").replaceAll("PM", "م"),
              );
            }) : Container();
      },
    );
  }
  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      String msg= messageEditingController.text.toString().trim();
      Map<String, dynamic> chatMessageMap = {
        "seen":"",
        "sendBy": "${Constant.id}",
        "friend_id":"${widget.friend_id.split("friend:").last.toString().split("}").first.toString()}",
        "message": messageEditingController.text.toString().trim(),
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
        "timeshow":"${DateTime.now().year.toString()+":"+DateTime.now().month.toString()
      +":"+DateTime.now().day.toString()+"&"+DateFormat.jm().format(DateTime.now())}",
      };
      DatabaseMethods().addMessage("${Constant.id+":"+listLength.toString()}",
          "${widget.chatRoomId.toString()}",
          "${widget.friend_id.toString()}",
          "${widget.friend_name.toString()}",
          chatMessageMap);
      setState(() {
        messageEditingController.text = "";
      });
      DatabaseMethods().getChats("${widget.chatRoomId.toString()}").then((val) {
        setState(() {
          chats = val;
        });
      });
      setState(() {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          setState(() {
            chatMessages();
          });
        });
      });


    }
  }
  @override
  void initState() {
    Firebase.initializeApp();
    DatabaseMethods().getChats("${widget.chatRoomId.toString()}").then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: appColor,
        title:Text("${widget.friend_name}",style: TextStyle(color:
        colorWhite),),
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorWhite, opacity: 12, size: 25),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
               child: chatMessages(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  color: Colors.black45,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                            controller: messageEditingController,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                                hintText: translate("chat.type_message"),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none
                            ),
                          )),
                      SizedBox(width: 16,),
                      GestureDetector(
                        onTap: () {
                          addMessage();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: Icon(Icons.send,color: appColor,)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String timeshow;
  MessageTile({@required this.message, @required this.sendByMe,@required this.timeshow});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            color: sendByMe?appColor:Theme.of(context).primaryColorLight
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("$message",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: sendByMe?colorWhite:
                    Theme.of(context).hintColor,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 3,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${timeshow.toString().split("&").last.toString()}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: sendByMe?colorWhite:Theme.of(context).hintColor,
                      fontSize: 10,
                      fontFamily: 'OverpassRegular',
                    )),
                 Visibility(
                  visible: (DateTime.now().year.toString()+":"+DateTime.now().month.toString()
                     +":"+DateTime.now().day.toString()).toString() ==timeshow.toString().split("&").first.toString()?false:true,
                   child:Text("${timeshow.toString().split("&").first.toString()}",
                     textAlign: TextAlign.start,
                     style: TextStyle(
                       color: sendByMe?Theme.of(context).primaryColor:Theme.of(context).hintColor,
                       fontSize: 9,
                       fontFamily: 'OverpassRegular',
                     )),
               ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}