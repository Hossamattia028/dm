import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_translate/flutter_translate.dart';

Widget reView(int amount){
  if(amount <= 10){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.star,size: 16,color: Colors.amber,),
      ],
    );
  }else if (amount <= 50 && amount >10){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
      ],
    );
  }else if (amount <= 100 && amount > 50){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
      ],
    );
  }else if (amount <= 150 && amount >100){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
      ],
    );
  }else if (amount <= 200 && amount >150){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
        Icon(Icons.star,size: 16,color: Colors.amber,),
      ],
    );
  }

}

// alertSetRate(BuildContext context){
//   Widget cancelButton = FlatButton(
//     child: Text(translate("button.cancel")),
//     onPressed: () async {
//       Navigator.of(context, rootNavigator: true).pop();
//     },
//   );
//   Widget okButton = new Align(
//     alignment: Alignment.center,
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//       child: FlatButton(
//         color: appColor,
//         child: Text(
//           translate("button.ok"),
//           style: TextStyle(
//               color: colorWhite,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2.0),
//         ),
//         onPressed: ()  {
//
//         },
//       ),
//     ),
//   );
//   AlertDialog alert=AlertDialog(
//     title: Text(translate("app_bar.your_review")),
//     content:SizedBox(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           RatingBar.builder(
//             initialRating: 3,
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: true,
//             itemCount: 5,
//             itemBuilder: (context, _) => Icon(
//               Icons.star,
//               color: Colors.amber,
//             ),
//             onRatingUpdate: (rating) {
//               print(rating);
//             },
//           ),
//         ],
//       ),
//     ),
//     actions: [
//       okButton,
//       cancelButton,
//     ],
//   );
//   showDialog(
//     barrierDismissible: false,
//     context:context,
//     builder:(BuildContext context){
//       return alert;
//     },
//   );
//
// }