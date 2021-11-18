import 'dart:io';
import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/sliderModel.dart';
import 'package:dmarketing/pages/merchant/market_root_pages.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MarketCategoriesProvider extends ChangeNotifier{
  String productsLength;

  Future<List<ProductDetails>> getMarketProducts(String id) async {
    List<ProductDetails> productsList = [];
    Uri uri = Uri.parse("${GlobalConfiguration().getString('api_base_url')}all/sallers/products");
     var params= {
       "saller_id":"$id",
    };
    final newURI = uri.replace(queryParameters: params);
    var response = await http.get(
      newURI,
      headers: {"Accept": "application/json",
       "Content-Type": "application/json",
        "x-api-key":"fatarnati",
        "Authorization": "Bearer ${Constant.token}",
      },
    );
    String responseBody = response.body;
    print("marketProducts: "+responseBody.toString());
    var responseJSON = json.decode(responseBody);
    if (response.statusCode == 200) {
        for (var data in responseJSON) {
            var thisList = ProductDetails(
              productId: data['id'].toString(),
              productName: Constant.lang=="ar"?data['title_ar'].toString():data['title_en'].toString(),
              discount: data['discount'].toString(),
              priceSale: data['price_with_discount'].toString(),
              productImage: data['photo'].toString(),
              // images: List<SliderModel>.from(
              //     data["images"].map((x) => SliderModel.fromJson(x))),
              price: data['price'].toString(),
              longDescription: Constant.lang=="ar"?data['text_ar'].toString():data['text_en'].toString(),
            );
            productsList.add(thisList);
            print("le: ${data['id'].toString() +data['photo'].toString()}");
          }
        productsLength= productsList.length.toString();

        var reversedList = productsList.reversed.toList();
    return reversedList;
   }
  }

  Future<List<ProductDetails>> getProductsBySeller(String sallerID) async {
    List<ProductDetails> productsList = [];
    Uri uri = Uri.parse("${GlobalConfiguration().getString('api_base_url')}all/sallers/products");
     var params= {
      "saller_id": "$sallerID",
    };
    final newURI = uri.replace(queryParameters: params);
    var response = await http.get(
      newURI,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati",
        "Authorization": "Bearer ${Constant.token}",
      },
    );
    String responseBody = response.body;
    print("productsBySaller$sallerID: "+responseBody.toString());
    List<SliderModel>  images=[];
    var responseJSON = json.decode(responseBody);
    if (response.statusCode == 200) {
        for (var data in responseJSON) {
         await getProductDetails(data['id'].toString()).then((value) {
           images = value.first.images;
         });
          var thisList = ProductDetails(
            // fav:data['product_favorite'].toString(),
            productId: data['id'].toString(),
            productName: Constant.lang=="ar"?data['title_ar'].toString():data['title_en'].toString(),
            discount: data['discount'].toString(),
            priceSale: data['price_with_discount'].toString().replaceAll("null", "").toString(),
            productImage:data['photo'].toString(),
            images: images,
            price: data['price'].toString(),
            longDescription: Constant.lang=="ar"?data['text_ar'].toString():data['text_en'].toString(),
          );
            productsList.add(thisList);
          }
    return productsList;
   }

  }

  Future<List<ProductDetails>> getProductDetails(String productID) async {
    List<ProductDetails> productsList = [];
    Uri uri = Uri.parse("${GlobalConfiguration().getString('api_base_url')}detailes/product");
     var params= {
      "product_id": "$productID",
    };
    final newURI = uri.replace(queryParameters: params);
    var response = await http.get(
      newURI,
      headers: {"Accept": "application/json",
       "Content-Type": "application/json",
        "x-api-key":"fatarnati"},
    );
    String responseBody = response.body;
    print("productDetails: "+responseBody.toString());
    var responseJSON = json.decode(responseBody);
    if (response.statusCode == 200) {
        // for (var data in responseJSON) {
            var thisList = ProductDetails(
              // fav: fav.toString(),
              productId: responseJSON['id'].toString(),
              productName: Constant.lang=="ar"?responseJSON['title_ar'].toString():responseJSON['title_en'].toString(),
              discount: responseJSON['discount'].toString(),
              priceSale: responseJSON['price_with_discount'].toString(),
              images: List<SliderModel>.from(
                  responseJSON["images"].map((x) => SliderModel.fromJson(x))),
              price: responseJSON['price'].toString(),
              longDescription: Constant.lang=="ar"?responseJSON['ar_text'].toString():responseJSON['text'].toString(),
            );
            productsList.add(thisList);
          // }
    return productsList;
   }

  }


}

