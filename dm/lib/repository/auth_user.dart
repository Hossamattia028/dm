import 'package:dmarketing/models/profile/address.dart';
import 'package:dmarketing/models/store/Categories.dart';
import 'package:flutter/widgets.dart';
import 'package:dmarketing/elements/ConstantWidget.dart';
import 'package:dmarketing/helper/ClientModel.dart';
import 'package:dmarketing/helper/Database.dart';
import 'package:dmarketing/helper/checkUser.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/main.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/cities.dart';
import 'package:global_configuration/global_configuration.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:dmarketing/root_pages.dart';


class UserAuth extends ChangeNotifier{
  bool stopApiRequest;
  String lat,lng;
  Future registerUser(
      {String userName,
      String email,
      String mobile,
      String password,
      BuildContext context}) async {
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}auth/signup";
    // ConstantWidget.loadingData(context: context);
    showToast("◌");
    var data = jsonEncode({
      'name':'$userName',
      'email':'$email',
      'password':'$password',
      'password_confirmation':'$password',
      'register_by':""
    });
    final response = await http.post(myUrl,
        headers: {"Accept": "application/json",
          "Content-Type": "application/json",
          "X-Requested-With":"XMLHttpRequest"
        },
    body: data);
    final decodeData = jsonDecode(response.body);
    print("sign up: "+response.body.toString());
    if(decodeData['result'].toString() == "true"){
      print(decodeData['user_id'].toString());
      await DBProvider.db.deleteAll();
      await DBProvider.db.newClient(Client(
          id: 0,
          username: "$userName",
          email: "$email",
          password: "$password",
          phone: "$mobile",
          country: "egypt",
          lang: Constant.lang=="ar"?"ar":"en",
          userId: "${decodeData['user_id'].toString()}",
          token: "${decodeData['user_id'].toString()}",
          blocked: false));
      await checkUser();
      await userProfile(decodeData['user_id'].toString());
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (BuildContext context) => MyApp()));
    }else if (decodeData['errors']['email'].toString().contains("Is Already Registered")){
     showToast(translate("signup.already_have_account"));
    }else{
      print("Register failed ");
    }
  }

  loginUser({String email, String password, BuildContext context}) async {
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}auth/login";
    // ConstantWidget.loadingData(context: context);
    showToast("◌");
    var data = jsonEncode({
      'email':'$email',
      'password':'$password',
    });
    final response = await http.post(myUrl,
        headers: {"Accept": "application/json",
          "Content-Type": "application/json", "X-Requested-With":"XMLHttpRequest"},
        body: data);
    print("log in: "+response.body.toString());
    final decodeData = jsonDecode(response.body);
    if(decodeData['result'].toString() == "true"){
      await DBProvider.db.deleteAll();
      await DBProvider.db.newClient(Client(
          id: 0,
          username: "${decodeData['user']['name'].toString()}",
          email: "$email",
          password: "${decodeData['user']['type'].toString()}",
          phone: "${decodeData['user']['phone'].toString()}",
          country: "egypt",
          lang: Constant.lang=="ar"?"ar":"en",
          userId: "${Constant.id}",
          token: "${decodeData['access_token'].toString()}",
          blocked: false));
      await checkUser();
      await userProfile("${decodeData['user']['id'].toString().trim()}");
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
          (BuildContext context) => MyApp()));
    }else if (decodeData['message'].toString().contains("Wrong")){
      showToast(translate("signup.not_sign"));
    }else{
      print("Log in failed ");
    }
  }

  Future userProfile(String id)async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}user/Info/$id";
    var response = await http.get(
      myUrl,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-Requested-With":"XMLHttpRequest"
      },
    );
    var decodedData = jsonDecode(response.body);
    // print(Constant.token.toString());
    print("user info: "+response.body.toString());
    if (response.statusCode == 200) {
    for(var data in decodedData['data']){
      Constant.id =  data['id'].toString().trim();
      Constant.userName = data['name'].toString();
      Constant.email = data['email'].toString();
      Constant.userPhone = data['phone'].toString();
      Constant.kind = data['type'].toString();
      Constant.userAddress = data['address'].toString();
      await DBProvider.db.updateClient(Client(
        id: 0,
        username: Constant.userName.toString(),
        email: Constant.email.toString(),
        token: Constant.token.toString(),
        lang: Constant.lang.toString(),
        phone:Constant.userPhone.toString(),
        userId: "${Constant.id}",
        password: "${Constant.kind}",
        country: Constant.lang.toString(),location: "${Constant.userAddress}"));
    }}
  }

  Future updateProfile({
    String name,
    String email,
    String mobile,
    String password,
    String address,
    BuildContext context
  })async{
    showToast("◌");
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}profile/update";
    var data ={
      'id':'${Constant.id}',
      'name':'$name',
      'password':'',
      'phone':'$mobile',
      'email':'$email',
      'address':'$address'
    };
    final response = await http.post(myUrl,
        headers: {
          "Authorization": "Bearer ${Constant.token}",
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-Requested-With":"XMLHttpRequest"
        },
        body: jsonEncode(data)
       );
    print(myUrl);
    print(data);
    print(Constant.token);
    print("update profile "+response.body.toString());
    final dataDecoded = jsonDecode(response.body);
    if(response.statusCode ==200) {
      await userProfile("${Constant.id}");
      await checkUser();
      showToast(translate("toast.update_user_data"));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
          RootPages(checkPage: "4",)), (Route<dynamic> route) => false);
    }else{
    }
  }
  Future resetPassword({String email,String oldPassword,
    String newPassword,BuildContext context})async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}change-password?old_password=$oldPassword&password=$newPassword&password_confirmation=$newPassword";
    ConstantWidget.loadingData(context: context);
    final response = await http.post(myUrl,
        headers: {'Content-Language': "ar",
          "Authorization": "Bearer ${Constant.token}",
         },
    );
    final data = jsonDecode(response.body);
    print("reset password: "+response.body.toString());
    if(response.statusCode==200){
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
          MyApp()), (Route<dynamic> route) => false);
    }else{
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
  Future forgetPassword({String id,BuildContext context})async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}forget_password";
    ConstantWidget.loadingData(context: context);
    final response = await http.post(myUrl,
        headers: {'Content-Language': "ar"},
        body:{
          "email": "$id",
        });
    final data = jsonDecode(response.body);
    if(response.statusCode==200){
      Navigator.of(context, rootNavigator: true).pop();
      print(response.body.toString());
    }else{

    }
  }



  Future newAddress({String address,BuildContext context})async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}edit-info?first_name=${Constant.userName.toString()}&last_name=${Constant.userName.toString()}&email=${Constant.email.toString()}&phone=${Constant.userPhone.toString()}&address=$address";
    ConstantWidget.loadingData(context: context);
    final response = await http.post(myUrl,
      headers: {"Authorization": "Bearer ${Constant.token}",
        'Accept': "application/json"},);
    final data = jsonDecode(response.body);
    print(response.body.toString());
    if(response.statusCode==200){
      showToast(translate("toast.update_user_data"));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MyApp()),
              (Route<dynamic> route) => false);
    }else{

    }
  }
  Future<String>addAddress({String address,String city_id,String state_id})async{
    print("lat$lat");
    print("lng$lng");
    if(lat==null){
      return "not";
    }else{
      final String myUrl = "${GlobalConfiguration().getString('api_base_url')}add-address?city_id=$city_id&state_id=$state_id&address=$address&lat=$lat&lng=$lng";
      var response = await http.post(
        myUrl,
        headers: {
          "Authorization": "Bearer ${Constant.token}",
          'Accept': "application/json"
        },
      );
      var decodedData = jsonDecode(response.body);
      print("address: "+response.body.toString());
      return Constant.userName;
    }

  }
  Future<String>removeAddress({String addressID})async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}delete-address?address_id=$addressID";
    var response = await http.post(
      myUrl,
      headers: {
        "Authorization": "Bearer ${Constant.token}",
        'Accept': "application/json"
      },
    );
    var decodedData = jsonDecode(response.body);
    print(Constant.token.toString());
    print("remove address: "+response.body.toString());
    return "true";
  }
  Future<List<Categories>>regions()async{
    List<Categories> list = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}regions";
    var response = await http.get(
      myUrl,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati"
      },
    );
    var decodedData = jsonDecode(response.body.toString());
    // print(Constant.token.toString());
    // print("regions: "+response.body.toString());
    if (response.statusCode == 200) {
      if(Constant.regions.value.length==0) {
        for (var data in decodedData['reigons']) {
          var thisList = Categories(
            name: Constant.lang=="ar"?data['name_ar'].toString():
            data['name_en'].toString(),
            id: data['id'].toString(),
            city_id: data['city_id'].toString(),
          );
          list.add(thisList);
          Constant.regions.value.add(thisList);
        }
      }
    }
    return list;
  }
  Future<List<Categories>>cities()async{
    List<Categories> list = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}cities";
    var response = await http.get(
      myUrl,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati"
      },
    );
    var decodedData = jsonDecode(response.body.toString());
    // print(Constant.token.toString());
    // print("cities: "+response.body.toString());
    if (response.statusCode == 200) {
      if(Constant.cities.value.length==0) {
        for (var data in decodedData['cities']) {
          var thisList = Categories(
            name: Constant.lang=="ar"?data['name_ar'].toString():
            data['name_en'].toString(),
            id: data['id'].toString(),
          );
          list.add(thisList);
          Constant.cities.value.add(thisList);
        }
      }

    }
    return list;
  }

  Future<List<Cities>>state_id(String cityID)async{
    print("city id: "+cityID);
    List<Cities> list = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}states?city_id=$cityID";
    var response = await http.get(
      myUrl,
      headers: {
        'Accept': "application/json"
      },
    );
    var decodedData = jsonDecode(response.body.toString());
    // print(Constant.token.toString());
    print("states: "+response.body.toString());
    if (response.statusCode == 200) {
      for (var data in decodedData) {
        var thisList = Cities(
          name: Constant.lang=="ar"?data['ar_title'].toString():
          data['title'].toString(),
          id: data['id'].toString(),
        );
        list.add(thisList);
      }
    }
    return list;
  }
  Future<List<AddressModel>>userAddress()async{
    List<AddressModel> list=[];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}my-addresses";
    var response = await http.post(
      myUrl,
      headers: {
        "Authorization": "Bearer ${Constant.token}",
        'Accept': "application/json"
      },
    );
    var decodedData = jsonDecode(response.body);
    // print(Constant.token.toString());
    print("address: "+response.body.toString());
    if (response.statusCode == 200) {
      for (var data in decodedData['addresses']) {
        var thisList = AddressModel(
          id: data['id'].toString(),
          name: data['name'].toString(),
          city_name: Constant.lang=="ar"?data['city']['title_ar'].toString():
          data['city']['title_en'].toString(),
          state: Constant.lang=="ar"?data['state']['title_ar'].toString():
          data['state']['title_en'].toString(),
          // area: data['area'].toString(),
          // street: data['street'].toString(),
          // building: data['building'].toString(),
          // apartment: data['apartment'].toString(),
        );
        list.add(thisList);
      }
    }
    return list;
  }

}
