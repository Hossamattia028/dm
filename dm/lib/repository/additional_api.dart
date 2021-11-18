import 'package:dmarketing/models/store/Orders.dart';
import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:flutter/widgets.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/main.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AdditionalApiProvider extends ChangeNotifier {

  Future<List<OrdersModel>> getSliders() async {
    List<OrdersModel> orderList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}my-orders";
    var response = await http.post(
      myUrl,
      headers: {"Authorization": "Bearer ${Constant.token}",
        "Accept": "application/json",},
    );
    print("orders:\n "+response.body.toString());
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    if (response.statusCode == 200) {
      for (var data in responseJSON['orders']) {
        var thisList;
          thisList= OrdersModel(
            uploadId:  data['id'].toString(),
            orderNumber: data['order_number'].toString().trim(),
            shipping_fees: data['shipping_fees'].toString().trim(),
            tax: data['tax'].toString().trim(),
            order_date: data['date_arrive'].toString().split(" - ").first.
            toString(),
            discount: data['discount'].toString().trim(),
            orderPrice: data['total'].toString().trim(),
            location: (Constant.lang=="ar"?data['address']['city']['title_ar'].toString():
            data['address']['city']['title_en'].toString())+"," +
                data['address']['address'].toString().replaceAll("null", "").toString().trim(),
            date: data['created_at'].toString().split(" ").first.
            toString().split(".").first.toString().replaceAll("T"," /").toString(),
            productsList: List<ProductDetails>.from(
                data["items"].map((x) => ProductDetails.fromJson(x))),
          );
        orderList.add(thisList);
      }
      Constant.orderLength = orderList.length.toString();
    }
    return orderList;
  }

}

