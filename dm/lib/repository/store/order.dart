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

class Order extends ChangeNotifier {

  Future<List<OrdersModel>> getOrders() async {
    List<OrdersModel> orderList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}orders/${Constant.id}";
    var response = await http.get(
      myUrl,
      headers: {"Accept": "application/json",
        "Content-Type": "application/json",
        "X-Requested-With":"XMLHttpRequest",
        "Authorization":"Bearer ${Constant.token}"
      },
    );
    print("orders:\n "+response.body.toString());
    String responseBody = response.body;
    var responseJSON = json.decode(responseBody);
    if (response.statusCode == 200) {
      for (var data in responseJSON) {
         var thisList= OrdersModel(
            complete: data['delivery_status'].toString(),
            uploadId:  data['id'].toString(),
            orderNumber: data['id'].toString().trim(),
            // shipping_fees: data['shipping_fees'].toString().trim(),
            // tax: data['tax'].toString().trim(),
            // discount: data['discount'].toString().trim(),
            orderPrice: data['grand_total'].toString().trim(),
            date: data['created_at'].toString().split(" ").first.
            toString().split(".").first.toString().replaceAll("T"," /").toString(),
            price: data['grand_total'].toString(),
            code: data['code'].toString(),
            // productsList: List<ProductDetails>.from(
            //     data["product"].map((x) => ProductDetails.fromJson(x))),
          );
        orderList.add(thisList);
      }
      Constant.orderLength = orderList.length.toString();
    }
    var reversedList = orderList.reversed.toList();
    return reversedList;
  }

  Future<String> saveOrder({BuildContext context,String owner_id,String paymentType}) async {
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}order/store";
    var data = {
      "owner_id":"$owner_id",
      "user_id":"${Constant.id}",
      "payment_type": "$paymentType"
    };
    var response = await http.post(
      myUrl,
        headers: {"Accept": "application/json",
          "Content-Type": "application/json",
          "X-Requested-With":"XMLHttpRequest",
          "Authorization":"Bearer ${Constant.token}"
        },
      body: jsonEncode(data)
    );
    // print(data.toString());
    // print(myUrl);
    print("saveOrder: \n"+response.body);
    final re = jsonDecode(response.body);
    if (response.statusCode == 200) {
      showToast(translate("toast.successfully_order"));
      return "yes";
    } else {
      print(re.toString());
      return "no";
    }
  }





  // Future<String> addItemToOrder({String amount,
  //   String productId}) async{
  //   final String myUrl = "${GlobalConfiguration().getString('api_base_url')}add-order-item?order_id=$orderIDForAddAnotherProduct&product_id=$productId&qty=$amount";
  //   final response = await http.post(myUrl,
  //       headers: {
  //         "Authorization": "Bearer ${Constant.token}",
  //         'Accept': "application/json",});
  //   final data = jsonDecode(response.body);
  //   print("addItemToOrder: \n"+response.body);
  //   if(response.statusCode ==200) {
  //     if(data['message'].toString().trim().contains("Out")){
  //       showToast(translate("store.out_of_stock"));
  //     }else{
  //       showToast(translate("myorder.add_after_order_done"));
  //       // showToast(translate("activity_cart.add_success"));
  //     }
  //   }else{
  //     // showToast(response.body.toString());
  //   }
  //   if (data['message'].toString().trim().contains("In")){
  //     // showToast(translate("store.already_added_cart"));
  //     return "update";
  //     // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
  //     //     CartScreen()));
  //   }
  // }
  Future<List<OrderStatus>> getOrderStatus(String orderID)async{
    List<OrderStatus> orderStatusList = [];
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}get-order-status?order_id=$orderID";
    final response = await http.post(myUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${Constant.token}"},);
    print("orderStatus_$orderID: "+response.body.toString().split(',{"id":10,').last.toString());
    print(myUrl);
    var responseJSON = json.decode(response.body.toString());
    if(response.statusCode ==200) {
      for (var data in responseJSON['order_statuses']) {
        var thisList = OrderStatus(
          id: data['id'].toString(),
          content: Constant.lang=="ar"?data['name_ar'].toString():
          data['name_en'].toString(),
          active:  data['active'].toString(),
          updated_at:  data['updated_at'].toString(),
        );
        orderStatusList.add(thisList);
      }
    }else{
      // print(response.body.toString());
    }
    return orderStatusList;
  }
  Future<String> getOrderMainStatus(String orderID)async{
    String orderStatus ="";
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}get-order-status?order_id=$orderID";
    final response = await http.post(myUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${Constant.token}"},);
    // print("orderStatus: "+response.body.toString());
    var responseJSON = json.decode(response.body.toString());
    if(response.statusCode ==200) {
      for (var data in responseJSON['order_statuses']) {
        var thisList = OrderStatus(
          id: data['id'].toString(),
          content: Constant.lang=="ar"?data['name_ar'].toString():
          data['name_en'].toString(),
          active:  data['active'].toString(),
          updated_at:  data['updated_at'].toString(),
        );
        if(data['active'].toString()=="true"){
          orderStatus=Constant.lang=="ar"?data['name_ar'].toString():
          data['name_en'].toString();
        }
      }
    }else{
      // print(response.body.toString());
    }
    return orderStatus;
  }
  Future getTax()async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}tax";
    final response = await http.get(myUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${Constant.token}"},);
    print("tax: "+response.body.toString());
    var responseJSON = json.decode(response.body.toString());
    if(response.statusCode ==200) {
      Constant.orderTax.value =double.parse(responseJSON.toString()).toDouble();
    }else{
      // print(response.body.toString());
    }
    if(responseJSON.toString().contains("Discount Code Not Valid")){
      showToast("?????? ?????????? ?????? ????????");
    }
  }
  Future<String> getDelivery(String addressID)async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}address-shipping?address_id=$addressID";
    final response = await http.get(myUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${Constant.token}"},);
    print("price of Delivery: "+response.body.toString());
    var responseJSON = json.decode(response.body.toString());
    if(response.statusCode ==200) {
      Constant.orderDeliveryPrice.value= double.parse(responseJSON.toString()).toDouble();
      //
      // for (var data in responseJSON) {
      // if(addressID==data['id'].toString().trim()){
      //   print("yes");
      //   Constant.orderDeliveryPrice.value= double.parse(data['shipment'].toString().trim()).toDouble();
      // }
      // }
    }else{
      // print(response.body.toString());
    }
    return Constant.orderDeliveryPrice.value.toString();
  }
  Future<String> checkDiscount(String discount_code)async{
    final String myUrl = "${GlobalConfiguration().getString('api_base_url')}check-discount?discount_code=$discount_code";
    final response = await http.get(myUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${Constant.token}"},);
     print("check discount: "+response.body.toString());
     if(response.body.toString().contains("Discount Code Not Valid")){
       showToast(translate("store.copoun_wrong"));
     }
     return response.body.toString().trim();
  }

}

