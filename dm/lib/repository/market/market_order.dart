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

class MarketOrder extends ChangeNotifier {
  String orderLength;
  List<ProductDetails> productsList;

  Future<List<OrdersModel>> getOrders() async {
    List<OrdersModel> orderList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}saller/orders";
    var response = await http.get(
      myUrl,
      headers: {"Authorization": "Bearer ${Constant.token}",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "x-api-key":"fatarnati",},
    );
    print("orders:\n "+response.body.toString());
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    if (response.statusCode == 200) {
      for (var data in responseJSON['orders']) {
        var thisList = OrdersModel(
            // complete:  data['status'].toString().trim(),
            uploadId:  data['id'].toString(),
            orderNumber: data['id'].toString().trim(),
            // shipping_fees: data['shipping_fees'].toString().trim(),
            // tax: data['tax'].toString().trim(),
            // order_date: data['date_arrive'].toString().split(" - ").first.
            // toString(),
            // discount: data['discount'].toString().trim(),
            // orderPrice: data['total'].toString().trim(),
            // location: (Constant.lang=="ar"?data['address']['city']['title_ar'].toString():
            // data['address']['city']['title_en'].toString())+"," +
            //     data['address']['address'].toString().replaceAll("null", "").toString().trim(),
            date: data['created_at'].toString().split(" ").first.toString(),
            // productsList: List<ProductDetails>.from(
            //     data["items"].map((x) => ProductDetails.fromJson(x))),
          );

        orderList.add(thisList);

      }
      orderLength = orderList.length.toString();
      print(orderLength);
      Constant.orderLength = orderList.length.toString();
    }
    var reversedList = orderList.reversed.toList();
    return reversedList;
  }

  Future saveOrder({BuildContext context,String addressID,String code,
  String date,String time,String note}) async {
    print("address_id: "+addressID.toString());
    print("code: "+code.toString());
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}mobile-checkout?address_id=$addressID&payment_method_id=2&discount_code=$code&date_arrive=$date&time_arrive=$time&notes=$note";
    var response = await http.get(
      myUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${Constant.token}"},
    );
    print("saveOrder: \n"+response.body);
    final re = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Constant.cartList.value.clear();
      showToast(translate("toast.successfully_order"));
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //         builder: (context) => OrdersPage()),
      //     (Route<dynamic> route) => false);
    } else {
      print(re.toString());
      // Navigator.of(context).pop();
      // showToast(response.body.toString());
    }
    if(re.toString().contains("Discount Code Not Valid")){
      showToast("كود الخصم غير صحيح");
    }
  }

}

