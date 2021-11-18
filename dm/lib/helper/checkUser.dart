
import 'package:flutter/material.dart';
import 'package:dmarketing/helper/Database.dart';
import 'package:dmarketing/models/Constant.dart';

checkUser({bool existID})async {
 await DBProvider.db.checkExistdb().then((value)async{
    if(value.toString()=="0"){
      print("sqlLite no user found "+value.toString());
      Constant.id=null;
      Constant.kind=null;
      Constant.token=null;
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LogIn()));
    }else{
      // if(existID!=false)Constant.id='exist';
      print("sqlLite user found ");
      await DBProvider.db.getEmail(0).then((email){
        Constant.email=email.toString().trim();
        print("email:"+Constant.email.toString());
      });
      await DBProvider.db.getuserPhone(0).then((userphone){
        Constant.userPhone=userphone.toString();
      });
      await DBProvider.db.getUsername(0).then((username){
          Constant.userName=username.toString().trim();
          print("userName:"+Constant.userName.toString());
      });
      await DBProvider.db.getUserpassword(0).then((pass){
        Constant.userPassword=pass.toString().trim();
        print("userPassword:"+Constant.userPassword.toString());
      });
      await DBProvider.db.getuserCountry(0).then((country){
        // Constant.userCountry=country.toString().trim();
      });
      DBProvider.db.getUserpassword(0).then((userKind){
        Constant.kind=userKind.toString().trim();
      });
      await DBProvider.db.getCurrentLang(0).then((currentLang){
        Constant.lang=currentLang.toString().trim();
        print("current language: "+currentLang);
      });
      await DBProvider.db.getuserId(0).then((userID){
        Constant.id=userID.toString().trim();
        print("userID:"+userID);
      });
      await DBProvider.db.getUserToken(0).then((token)async{
        Constant.token=token.toString().trim();
        if(Constant.token=="discover"){
          Constant.id = null;
          print("discover user ");
        }
        print("token: "+Constant.token.toString());
      });
    }
  });
}