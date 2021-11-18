import 'package:dmarketing/helper/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryDetails extends StatefulWidget {
  String id,title,content,image,video;
  StoryDetails({this.id,this.title,this.content,
    this.image,this.video});
  @override
  _StoryDetailsState createState() => _StoryDetailsState();
}

class _StoryDetailsState extends State<StoryDetails> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "${widget.title}",
            backgroundColor: appColor,
          ),
          StoryItem.text(
            title: "Nice!\n\n${widget.content}",
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontFamily: 'Dancing',
              fontSize: 40,
            ),
          ),
          StoryItem.pageImage(
            url:
            "${widget.image}",
            caption: "Still sampling",
            controller: storyController,
          ),

        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
          Navigator.of(context).pop();
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}