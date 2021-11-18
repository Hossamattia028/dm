
import 'package:flutter/material.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/models/Options.dart';
import 'package:dmarketing/models/sliderModel.dart';

class ProductDetails {
  String mainId,categoryId,productImage,
      productName,
      shortDescription,
      longDescription,
      price,
      priceSale,
      marketPhone,
      marketName,
      amount,
      date,
      dept,
      uploadid,
      marketProductKind,deliverPrice,marketId,brandId,
      productId,stock_qty,discount,weight,owner_id;
  bool fav;
  String optionsString;
  List<Options> options;
  List<SliderModel> images;
  ProductDetails({
    this.mainId,
    this.categoryId,
    this.productImage,
    this.productName,
    this.shortDescription,
    this.longDescription,
    this.price,
    this.priceSale,
    this.marketPhone,
    this.marketName,
    this.amount,
    this.date,
    this.dept,
    this.uploadid,
    this.marketProductKind, this.deliverPrice,this.marketId,this.brandId,
    this.productId,this.options,this.optionsString,this.images,this.stock_qty,this.discount,
    this.fav,this.weight,this.owner_id
});


  ProductDetails.fromJson(Map<String, dynamic> jsonMap) {
    // productImage = jsonMap['image'].toString();
    // amount = jsonMap['quantity'].toString();
    productName = Constant.lang=="ar"?jsonMap['title_ar'].toString():
    jsonMap['title_en'].toString();
    priceSale = jsonMap['price'].toString();
    price = jsonMap['price'].toString();
    productId =jsonMap['id'].toString();
    // weight = Constant.lang=="ar"?jsonMap['weight'].toString().split("title_ar:").last.split("}").
    // first.toString().replaceAll("null", "").toString():
    // jsonMap['weight'].toString().split("title_en:").last.split(",").first
    //     .toString().replaceAll("null", "").toString();
  }

  @override
  String toString() {
    return '{ ${this.productId}, ${this.amount}, ${this.date}, ${this.categoryId} }';
  }
}
