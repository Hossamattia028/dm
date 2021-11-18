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

class StoriesProvider extends ChangeNotifier{
  Future<List<SliderModel>> getStories() async {
    List<SliderModel> storiesList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}story/all";
    var response = await http.get(
      myUrl,
      headers: {"Accept": "application/json",
        "Content-Type": "application/json",
        "X-Requested-With":"XMLHttpRequest",
        "Authorization":"Bearer ${Constant.token}"
      },
    );
    String responseBody = response.body;
    print("stories: "+response.body);
    // print(myUrl);
    if (response.statusCode == 200) {
      var responseJSON = json.decode(responseBody);
      for (var data in responseJSON) {
        var thisList = SliderModel(
          id: data['id'].toString(),
          name: data['title'].toString(),
          description: data['content'].toString(),
          image: data['image'].toString(),
        );
        storiesList.add(thisList);
      }
    }
    return storiesList;
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

