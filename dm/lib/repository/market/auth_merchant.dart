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
import 'package:dmarketing/pages/merchant/market_root_pages.dart';
import 'dart:async';

import 'package:dmarketing/root_pages.dart';


class MerchantAuth extends ChangeNotifier{
  String lat,lng;
  Future registerMerchant(
      {String userName,
        String email,
        String mobile,
        String password,
        String code,
        String cityID,String regionID,
        BuildContext context,String merchantKind}) async {
    String param = "add/sallers";
    if(merchantKind=="service") param="add/sallers/services";
    print(param);
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}$param";
    // ConstantWidget.loadingData(context: context);
    showToast("◌");
    var data;
    if(merchantKind=="service"){
      print("on service sign up");
      data = jsonEncode({
        'name':'$userName',
        'phone':'$mobile',
        'desc':'.',
        'email':'$email',
        'image':"",
        'address_en':'address',
        'address_ar':'address',
        'map':'$password',
        'password':'$password',
        'commercial_register':'',
        'nationalist':'',
        'code':'$code',
        'city_id':'$cityID',
        'region_id':"$regionID",
        'cat_id':'7',
        'instgram_link':'sdf',
        'twitter_link':'dfs',
        'facebook_link':'sdf',
        'youtube_link':'sf',
      });
    }else{
      data = jsonEncode({
        'name_en':'$userName',
        'name_ar':'$userName',
        'phone':'$mobile',
        'address_en':'address',
        'address_ar':'address',
        'map':'$password',
        'password':'$password',
        'image':'',
        'commercial_register':'',
        'nationalist':'',
        'code':'$code',
        'city_id':'$cityID',
        'region_id':"$regionID",
        'instgram_link':'sdf',
        'twitter_link':'dfs',
        'facebook_link':'sdf',
        'youtube_link':'sf',
      });
    }
    final response = await http.post(myUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "x-api-key":"fatarnati"
        },
        body: data);
    final decodeData = jsonDecode(response.body);
    print("marketSignUpInput: "+data);
    print("$merchantKind signUp: "+response.body.toString());
    if(decodeData['message'].toString().trim().contains("Successfully")||
        decodeData['status'] == 'true'){
      print("token: "+decodeData['token'].toString());
      await DBProvider.db.deleteAll();
      await DBProvider.db.newClient(Client(
          id: 0,
          username: "$userName",
          email: "$email",
          password: "$password",
          phone: "$mobile",
          country: "egypt",
          lang: "ar",
          userId: "$merchantKind",
          token: "${decodeData['token'].toString()}",
          blocked: false));
      await checkUser();
      if(merchantKind=="market"){
        await dataMarketProfile();
      }else{
        await dataServiceProfile();
      }
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
          (context)=> MarketRootPages()),
              (Route<dynamic> route) => false);
    }else if (decodeData['errors'].toString().contains("Is Already Registered")){
      showToast(translate("signup.already_have_account"));
    }else if (decodeData['status'].toString().contains("false")){
      // showToast(translate("signup.wrong_code"));
    } else{
      print("Register failed ");
    }
  }

  loginMerchant({String email, String password,
    BuildContext context,String merchantKind}) async {
    String param = "login/sallers";
    if(merchantKind=="service") param="login/sallers/services";
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}$param";
    // ConstantWidget.loadingData(context: context);
    showToast("◌");
    var data = jsonEncode({
      'phone':'$email',
      'password':'$password',
    });

    final response = await http.post(myUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "x-api-key":"fatarnati"
        },
        body: data);
    print(myUrl.toString());
    print(data.toString());
    print("merchant log in: "+response.body.toString());
    final decodeData = jsonDecode(response.body);
    print("status: "+decodeData['status'].toString());
    print("loginKind: "+merchantKind.toString());
    if(decodeData['status'].toString()=="true"){
      await DBProvider.db.deleteAll();
      await DBProvider.db.newClient(Client(
          id: 0,
          username: "userame",
          email: "$email",
          password: "$password",
          phone: "userphone",
          country: "egypt",
          lang: "ar",
          userId: "$merchantKind",
          token: "${decodeData['token'].toString()}",
          blocked: false));
      await checkUser();
      if(merchantKind=="market"){
        await dataMarketProfile();
      }else{
        await dataServiceProfile();
      }
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
          (context)=> MarketRootPages()),
              (Route<dynamic> route) => false);
    }else if (decodeData['message'].toString().contains("Invalid Inputs")||
        decodeData.toString().contains("errors")){
      showToast(translate("signup.not_sign"));
    }else{
      print("Log in failed ");
    }
  }

  Future updateProfile({
    String userName,
    String mobile,
    String password,
    String cityID,
    String id,String address,String face,String twitter,String instagram,
    String whatsApp,String mobilePhone,
    BuildContext context
  })async{
    print("$instagram");
    print("$twitter");
    print("$face");
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}edit/sallers";
    var data = {
      'name_en':'$userName',
      'name_ar':'$userName',
      'phone':'$mobile',
      'address_en':'$address',
      'address_ar':'$address',
      'map':'$password',
      'password':'$password',
      'image':'',
      'commercial_register':'',
      'nationalist':'',
      'city_id':'$cityID',
      'id':'$id',
      'region_id':'${Constant.region_id}',
      'instgram_link':'$instagram',
      'twitter_link':'$twitter',
      'facebook_link':'$face',
      'whatsapp_link':'$whatsApp',
      'mobile_link':'$mobilePhone',
      'youtube_link':'sf',
    };
    print("updateMarket: "+data.toString());
    final response = await http.post(myUrl,
        headers: {
          "Authorization": "Bearer ${Constant.token}",
          "Accept": "application/json",
          "x-api-key":"fatarnati"
        },
        body: data
    );
    print("update profile "+response.body.toString());
    final dataDecoded = jsonDecode(response.body);
    if(response.statusCode ==200) {
      await dataMarketProfile();
      showToast(translate("toast.update_user_data"));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
          MarketRootPages(checkPage: "4",)), (Route<dynamic> route) => false);
    }else{
    }
  }

  Future<String> dataMarketProfile()async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}profile/saller";
    var response = await http.get(
      myUrl,
      headers: {
        "Authorization": "Bearer ${Constant.token}",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati"
      },
    );
    var decodedData = jsonDecode(response.body);
    // print(Constant.token.toString());
    print("market info: "+response.body.toString());
    if (response.statusCode == 200) {
      Constant.userName = Constant.lang=="ar"?
      decodedData['saller']['name_ar'].toString():
      decodedData['saller']['name_en'].toString();
      Constant.email = decodedData['saller']['email'].toString();
      Constant.userPhone = decodedData['saller']['phone'].toString();
      Constant.userAddress = Constant.lang=="ar"?decodedData['saller']['address_ar'].toString():
      decodedData['saller']['address_en'].toString();
      Constant.cityID = decodedData['saller']['city_id'].toString();
      Constant.id = decodedData['saller']['id'].toString();
      Constant.region_id = decodedData['saller']['region_id'].toString();
      Constant.facebook = decodedData['saller']['facebook_link'].toString();
      Constant.instagram = decodedData['saller']['instgram_link'].toString();
      Constant.twitter = decodedData['saller']['twitter_link'].toString();
    }
    await DBProvider.db.updateClient(Client(
        id: 0,
        username: "${Constant.userName}",
        email: "${Constant.email}",
        phone: "${Constant.userPhone}",
        lang: Constant.lang,
        token:Constant.token ,
        location: Constant.userAddress,
        userId: Constant.kind,
        blocked: false));
    await checkUser(existID: false);
    return Constant.id.toString();
  }
  Future<String> dataServiceProfile()async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}profile/saller/services";
    var response = await http.get(
      myUrl,
      headers: {
        "Authorization": "Bearer ${Constant.token}",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati"
      },
    );
    var decodedData = jsonDecode(response.body);
    // print(Constant.token.toString());
    print("service info: "+response.body.toString());
    if (response.statusCode == 200) {
      Constant.userName = Constant.lang=="ar"?
      decodedData['data']['name'].toString():
      decodedData['data']['name'].toString();
      Constant.email = decodedData['data']['email'].toString();
      Constant.userPhone = decodedData['data']['phone'].toString();
      Constant.userAddress = Constant.lang=="ar"?decodedData['data']['address_ar'].toString():
      decodedData['data']['address_en'].toString();
      Constant.cityID = decodedData['data']['city_id'].toString();
      Constant.id = decodedData['data']['id'].toString();
      Constant.region_id = decodedData['data']['region_id'].toString();
    }
    await DBProvider.db.updateClient(Client(
        id: 0,
        username: "${Constant.userName}",
        email: "${Constant.email}",
        phone: "${Constant.userPhone}",
        lang: Constant.lang,
        token:Constant.token ,
        location: Constant.userAddress,
        userId: Constant.kind,
        blocked: false));
    await checkUser(existID: false);
    return Constant.id.toString();
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
}

Future addDeviceToken({String token})async{
  final String myUrl = "${GlobalConfiguration().getString('api_base_url')}save-device-token?device_token=$token";
  final response = await http.post(myUrl,
    headers: {'Accept': "application/json",
      "Authorization": "Bearer ${Constant.token}",},);
  final data = jsonDecode(response.body);
  print("$token");
  print("token: "+response.body.toString());
  if(response.statusCode==200){
    print("good device token");
  }else{
    print("error when add device token");
  }
}


