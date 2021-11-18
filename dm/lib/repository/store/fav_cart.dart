import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:flutter/widgets.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class FavAndCart extends ChangeNotifier{
  String ownerProductsId = "";

  Future addToFavourite({String productID}) async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}wishlists";
    var data={
      "user_id":"${Constant.id}",
      "product_id":"$productID",
    };
    final response = await http.post(myUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-Requested-With":"XMLHttpRequest",
          "Authorization":"Bearer ${Constant.token}"
        },
        body: jsonEncode(data)
    );
    print("addFav$productID: "+response.body.toString());
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    if(responseJSON['result'].toString().trim().contains("true")){
      return "yes";
    }else{
      return "no";
    }
  }

  Future<String>  removeFromFavourite({String ID}) async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}wishlists/${ID.toString().trim()}";
    final response = await http.delete(myUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-Requested-With":"XMLHttpRequest",
          "Authorization":"Bearer ${Constant.token}"
        },
    );
    print("removeFav$ID: "+response.body.toString());
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    if(responseJSON['result'].toString().trim().contains("true")){
      return "yes";
    }else{
      return "no";
    }
  }

  Future<List<ProductDetails>> getFavProducts() async {
    List<ProductDetails> productsList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}wishlists/${Constant.id}";
    var response = await http.get(
      myUrl,
      headers: {"Accept": "application/json",
        "Content-Type": "application/json",
        "X-Requested-With":"XMLHttpRequest",
        "Authorization":"Bearer ${Constant.token}"
      },
    );
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    // print("token: ${Constant.token}");
    print("fav: "+responseJSON.toString());
    if (response.statusCode == 200) {
      for (var data in responseJSON['data']) {
        var thisList = ProductDetails(

            productId: data['id'].toString(),
            productName: Constant.lang=="ar"?data['product']['name'].toString():data['product']['title_en'].toString(),
            productImage:GlobalConfiguration().getString('base_url').toString()+
                data['product']['thumbnail_image'].toString(),
            price: data['product']['base_price'].toString(),
            priceSale: data['product']['base_price'].toString(),
            // discount: data['product']['discount'].toString(),
            longDescription: Constant.lang=="ar"?data['product']['text_ar'].toString():data['product']['text_en'].toString(),
        );
        // print(data['product_id'].toString()+":"+data['product']['photo'].toString());
          productsList.add(thisList);
      }
    }
    // print("product fav:\n"+productsList.toString());
    return productsList;
  }

  Future<List<ProductDetails>> getCartProducts() async {
    List<ProductDetails> productsList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}carts/${Constant.id}";
    var response = await http.post(
      myUrl,
      headers: {"Accept": "application/json",
        "Content-Type": "application/json",
        "X-Requested-With":"XMLHttpRequest",
        "Authorization":"Bearer ${Constant.token}"
      },
    );
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    // print(myUrl);
    // print("token: ${Constant.token}");
    print("cart: "+responseJSON.toString());
    // if (response.statusCode == 200) {
      for (var dataa in responseJSON) {
        ownerProductsId = dataa['owner_id'].toString();
        for (var data in dataa['cart_items']) {
          var thisList = ProductDetails(
            owner_id: dataa['owner_id'].toString(),
            productId: data['product_id'].toString(),
            uploadid: data['id'].toString(),
            productName: data['product_name'].toString(),
            productImage: GlobalConfiguration()
                .getString('base_url')
                .toString() +
                data['product_thumbnail_image'].toString(),
            price: data['price'].toString(),
            priceSale: data['price'].toString(),
            // discount: data['product']['discount'].toString(),
            // longDescription: Constant.lang=="ar"?data['product']['text_ar'].toString():data['product']['text_en'].toString(),
          );
          // print(data['product_id'].toString()+":"+data['product']['photo'].toString());
          productsList.add(thisList);
        }
      }
    // }
    // print("product fav:\n"+productsList.toString());
    return productsList;
  }

  Future addToCart({String productID}) async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}carts/add";
    var data={
      "id":"$productID",
      "variant":"",
      "user_id":"${Constant.id}",
      "quantity":"1",
    };
    final response = await http.post(myUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-Requested-With":"XMLHttpRequest",
          "Authorization":"Bearer ${Constant.token}"
        },
        body: jsonEncode(data)
    );
    print("addCart$productID: "+response.body.toString());
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    if(responseJSON['result'].toString().trim().contains("true")){
      showToast(translate("activity_cart.add_success"));
      return "yes";
    }else{
      showToast(translate("toast.oops"));
      return "no";
    }
  }


}

