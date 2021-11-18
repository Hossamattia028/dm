import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/global.dart';
import 'package:global_configuration/global_configuration.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/pages.dart';

class About extends ChangeNotifier {

  Future<String> getAbout() async {
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}about/app";
    var response = await http.get(
      myUrl,
      headers: {
        "Accept": "application/json",
        "x-api-key":"fatarnati",
        "Content-Type": "application/json",
      });
    print("aboutResponse: \n"+response.body);
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    return Constant.lang=="ar"?responseJSON['text'].toString().trim():
    responseJSON['text'].toString().trim();
  }

  Future<String> getPrivacy() async {
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}about/app";
    var response = await http.get(
      myUrl,
      headers: {
        "Accept": "application/json",
        "x-api-key":"fatarnati",
        "Content-Type": "application/json",
      });
    print("aboutResponse: \n"+response.body);
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    return Constant.lang=="ar"?responseJSON['text'].toString().trim():
    responseJSON['text'].toString().trim();
  }

  Future<String> getContact() async {
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}contact";
    var response = await http.get(
      myUrl,
      headers: {
        "Accept": "application/json",
        "x-api-key":"fatarnati",
        "Content-Type": "application/json",
      });
    print("aboutResponse: \n"+response.body);
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    return Constant.lang=="ar"?responseJSON['text'].toString().trim():
    responseJSON['text'].toString().trim();
  }

  Future sendContact({String msg,
    String email,String name,String mobile})async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}contact?name=$name&email=$email&phone=$mobile&subject=contact&msg=$msg";
    showToast("◌");
    final response = await http.get(myUrl,
      headers: {
        "Accept": "application/json",
      });
    print("sendContact: "+response.body.toString());
    if(response.statusCode ==200) {
      print("good response for sendContact");
      showToast(translate("toast.good_sent_message"));
    }else{
      // showToast(response.body.toString());
    }
  }
}