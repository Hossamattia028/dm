import 'dart:io';
import 'package:dmarketing/models/profile/UserData.dart';
import 'package:dmarketing/models/profile/selller.dart';
import 'package:dmarketing/models/store/Categories.dart';
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

class CategoriesProvider extends ChangeNotifier{

  Future<List<UserData>> getAllCustomers() async {
    List<UserData> globalList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}users";
    var response = await http.get(
      myUrl,
      headers: {"Accept": "application/json",
        "Content-Type": "application/json",
      },
    );
    String responseBody = response.body;
    // print("slider data:\n"+response.body);
    // print(myUrl);
    if (response.statusCode == 200) {
      var responseJSON = json.decode(responseBody);
      for (var data in responseJSON) {
        var thisList = UserData(
          authid: data['id'].toString(),
          username: data['name'].toString(),
          email: data['email'].toString(),
          image: data['avatar'].toString(),
          mobilePhone:data['phone'].toString(),
        );
        globalList.add(thisList);
      }
    }
    return globalList;
  }

  Future<List<SliderModel>> getSlider() async {
    List<SliderModel> sliderList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}sliders";
    var response = await http.get(
      myUrl,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati",},
    );
    String responseBody = response.body;
    // print("slider data:\n"+response.body);
    // print(myUrl);
    if (response.statusCode == 200) {
      var responseJSON = json.decode(responseBody);
      for (var data in responseJSON) {
        var thisList = SliderModel(
          image: data['image'].toString(),
        );
        sliderList.add(thisList);
      }
    }
    return sliderList;
  }

  Future<List<Categories>> getCategories({bool home,bool asMarket}) async {
    List<Categories> categoryList = [];
    final String url = "${GlobalConfiguration().getString('api_base_url')}${asMarket == true?"categories":"categories/services"}";
    var response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati",},
    );
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    print("AllCategories: "+responseJSON.toString());
    // print("asMarket: "+asMarket.toString());
    if (response.statusCode == 200) {
      if(Constant.categories.value.length==0){
        for (var data in responseJSON['data']) {
          var thisList = Categories(
            id: data['id'].toString(),
            name: Constant.lang=="ar"?data['title_ar'].toString():data['title_en'].toString(),
            image: data['image'].toString(),
            // main_category_id: data['main_category_id'].toString(),
          );
          categoryList.add(thisList);
          Constant.categories.value.add(thisList);
        }
      }

      if(home==true){
        for (var data in asMarket == true?responseJSON['data']
            :responseJSON) {
          var thisList = Categories(
            id: data['id'].toString(),
            name: asMarket==true?(Constant.lang=="ar"?data['title_ar'].toString():data['title_en'].toString()):
            (Constant.lang=="ar"?data['name_ar'].toString():data['name_en'].toString()),
            image: data['image'].toString(),
            // main_category_id: data['main_category_id'].toString(),
          );
          categoryList.add(thisList);
        }
      }

    }
    return categoryList;
  }

  Future<List<Categories>> getSubCategories(String catID) async {
    List<Categories> categoryList = [];
    final String url = "${GlobalConfiguration().getString('api_base_url')}categories/sub";
    var response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati",
        "Authorization": "Bearer ${Constant.token}",
      },
    );
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    print("subCategories$catID: "+responseJSON.toString());
    if (response.statusCode == 200) {
      if(Constant.subCategories.value.length==0){
        for (var data in responseJSON['categories']) {
          var thisList = Categories(
            id: data['id'].toString(),
            name: Constant.lang=="ar"?data['title_ar'].toString():data['title_en'].toString(),
            image: data['image'].toString(),
            main_category_id: data['cat'].toString(),
          );
            Constant.subCategories.value.add(thisList);
          }
      }
      for (var data in responseJSON['categories']) {
        var thisList = Categories(
          id: data['id'].toString(),
          name: Constant.lang=="ar"?data['title_ar'].toString():data['title_en'].toString(),
          image: data['image'].toString(),
          main_category_id: data['cat'].toString(),
        );
        if(data['cat'].toString()=="$catID"){
          categoryList.add(thisList);
        }
      }
    }
    return categoryList;
  }

  Future<List<SellerModel>> getSellers({String catID}) async {
    List<SellerModel> partnerList = [];
    String route="all/sallers";
    if(catID!=null){route="all/sallers/cats";}
    var response ;
    Uri uri;
      uri = Uri.parse("${GlobalConfiguration().getString('api_base_url')}$route");
      var params= {
        "cat_id": "$catID",
      };
      final newURI = uri.replace(queryParameters: params);
      response = await http.get(
        newURI,
        headers: {"Accept": "application/json",
          "Content-Type": "application/json",
          "x-api-key":"fatarnati"},
      );
      print(newURI);

    String responseBody = response.body;
    print("sellers: "+response.body.toString());
    print("region: "+Constant.region_id.toString());
    var responseJSON = json.decode(responseBody);
    if (response.statusCode == 200) {
      for (var data in catID!=null?responseJSON['data']:responseJSON) {
        var thisList = SellerModel(
            id: data['id'].toString(),
            mobilePhone: data['phone'].toString(),
            name: Constant.lang=="ar"?data['name_ar'].toString():data['name_en'].toString(),
            address: Constant.lang=="ar"?data['address_ar'].toString():data['address_en'].toString(),
            image:data['image'].toString()
        );
            partnerList.add(thisList);
      }
    }
    return partnerList;
  }

  Future<List<SellerModel>> getSellersServices({String catID}) async {
    List<SellerModel> partnerList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}all/sallers/services";
    var response = await http.get(
      myUrl,
      headers: {"Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati"},
    );
    String responseBody = response.body;
    // print(myUrl);
    print("sellersServices: "+response.body.toString());
    // print("region: "+Constant.region_id.toString());
    var responseJSON = json.decode(responseBody);
    if (response.statusCode == 200) {
      for (var data in responseJSON) {
        var thisList = SellerModel(
            id: data['id'].toString(),
            mobilePhone: data['phone'].toString(),
            name: Constant.lang=="ar"?data['name'].toString():data['name'].toString(),
            address: Constant.lang=="ar"?data['address'].toString():data['address'].toString(),
            image:data['image'].toString(),
            jobTitle:Constant.lang=="ar"?data['cat']['name_ar'].toString():
            data['cat']['name_en'].toString(),
            desc:data['desc'].toString(),
        );
        if(catID!=null&&catID.toString()!="null"){
            print("catID: "+catID);
          if(catID.toString().trim()==data['cat_id'].toString().trim()){
            if(Constant.region_id.toString()!="null"&&Constant.region_id==data['region_id'].toString().trim()){
              partnerList.add(thisList);
            }else{
              partnerList.add(thisList);
            }
          }
        }else{
          if(Constant.region_id.toString()!="null"&&Constant.region_id==data['region_id'].toString().trim()){
            partnerList.add(thisList);
          }else{
            partnerList.add(thisList);
          }
        }
      }
    }
    return partnerList;
  }

  Future<List<ProductDetails>> getProducts() async {
    List<ProductDetails> productsList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}products";
    var response = await http.get(
      myUrl,
      headers: {"Accept": "application/json",
       "Content-Type": "application/json",
      },
    );
    // print(Constant.token);
    String responseBody = response.body;
    print("products: "+responseBody.toString());
    var responseJSON = json.decode(responseBody);
    List<ProductDetails> productDetailsAdditionalInfo=[];
    bool fav = false;
    if (response.statusCode == 200) {
        for (var data in responseJSON['data']) {
            // if(checkDetails==true){
            //   await getProductDetails(data['id'].toString()).then((value) {
            //     productDetailsAdditionalInfo.add(value.first);
            //   });
            // }
          await checkFavProducts(data['id'].toString()).then((value) {
            fav= value;
          });
            var thisList = ProductDetails(
              productId: data['id'].toString(),
              productName: data['name'].toString(),
              productImage: GlobalConfiguration().getString('base_url').toString()
                  +data['thumbnail_image'].toString(),
              // discount: data['discount'].toString(),
              // priceSale: data['price_with_discount'].toString(),
              // productImage: data['photo'].toString(),
              // images: List<SliderModel>.from(
              //     data["images"].map((x) => SliderModel.fromJson(x))),
              price: data['base_price'].toString(),
              fav: fav,
              // fav:data['product_favorite'].toString()=="true"?true:false,
              // marketPhone: checkDetails==true?productDetailsAdditionalInfo.first.marketPhone:
              // data['id'].toString(),
              longDescription: Constant.lang=="ar"?data['name'].toString()
               :data['name'].toString(),
            );
            productsList.add(thisList);
          }
    return productsList;
   }
  }
  Future<bool> checkFavProducts(String productID) async {
    bool fav = false;
    print("ID: ${Constant.id}");
    String url = "${GlobalConfiguration().getString('api_base_url')}wishlists-check-product?product_id=$productID&user_id=${Constant.id}";
    var response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-Requested-With":"XMLHttpRequest",
          "Authorization":"Bearer ${Constant.token}"
        }
    );
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    print("checkFavProduct$productID "+responseJSON.toString());
    if (response.statusCode == 200) {
      if(responseJSON['is_in_wishlist'].toString().trim()=="true"){
        fav = true;
      }
    }
    return fav;
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
              marketId: responseJSON['id'].toString(),
              marketPhone: responseJSON['id'].toString(),
              marketName:  Constant.lang=="ar"?responseJSON['partner']['name_ar'].toString():
              responseJSON['partner']['name_en'].toString(),
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


  Future addProduct(
      {String productID,String text,String title,String price,String country,
        BuildContext context,File image_one,File image_two,String catID,String subCatID,
        String cityID, String discount,String size_one,String size_two}) async {
    // ConstantWidget.loadingData(context: context);
    showToast("◌");
    String fileNameOne = image_one.path.split('/').last;
    String fileNameTwo = image_two.path.split('/').last;
    final uri = Uri.parse(
        "https://dev.matrixclouds.com/fatarnati/public/api/add/products/saller");
    var request = http.MultipartRequest('POST', uri);
    request.headers['authorization'] = 'Bearer ${Constant.token}';
    request.headers['Accept'] = 'application/json';
    request.headers['Content-Type'] = 'application/json';
    request.headers['x-api-key'] = 'fatarnati';
    request.fields['title_en'] = "$title";
    request.fields['title_ar'] = "$title";
    request.fields['text_en'] = "$text";
    request.fields['text_ar'] = "$text";
    request.fields['price'] = "$price";
    request.fields['stock_qty'] = "2";
    request.fields['cat'] = "$catID";
    request.fields['sub_id'] = "$subCatID";
    request.fields['discount'] = "$discount";
    request.fields['start_discount'] = "$discount";
    request.fields['end_discount'] = "$discount";
    request.fields['sizes[0]'] = "$size_one";
    request.fields['sizes[1]'] = "$size_two";
    request.fields['prices[0]'] = "$price";
    request.fields['prices[1]'] = "$price";
    var pic_image_your_photo = await http.MultipartFile.fromPath(
        "photo", image_one.path);
    request.files.add(pic_image_your_photo);
    var pic_image_your_id = await http.MultipartFile.fromPath(
        "image[0]", image_one.path);
    request.files.add(pic_image_your_id);
    var pic_image_commercial_record = await http.MultipartFile.fromPath(
        "image[1]", image_two.path);
    request.files.add(pic_image_commercial_record);
    print(request.fields.toString());
    await request.send().then((result) async {
      http.Response.fromStream(result)
          .then((response) async {
        print("res\n"+response.body.toString());
        if(response.body.toString().contains("Successfully")){
          showToast(translate("store.done_uploaded_product"));
          Navigator.of(context).push(MaterialPageRoute(builder:
              (context)=>MarketRootPages(checkPage: "0",)));
        }
      });
      print(result.statusCode.toString());
    });

  }

}

