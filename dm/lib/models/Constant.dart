
import 'package:dmarketing/models/profile/address.dart';
import 'package:dmarketing/models/store/Categories.dart';
import 'package:dmarketing/models/store/ProductDetails.dart';
import 'package:flutter/material.dart';


class Constant{
  static String id;
  static String email;
  static String userName;
  static String userPhone;
  static String userPassword;
  static String cityID;
  static String region_id;
  static String userAddress;
  static String facebook;
  static String twitter;
  static String instagram;
  static String token;
  static String lang;
  static String kind;
  static String orderLength = "";

  static ValueNotifier <List<Categories>> cities = ValueNotifier <List<Categories>>([]);
  static ValueNotifier <List<Categories>> regions = ValueNotifier <List<Categories>>([]);
  static ValueNotifier <List<Categories>> categories = ValueNotifier <List<Categories>>([]);
  static ValueNotifier <List<Categories>> subCategories = ValueNotifier <List<Categories>>([]);

  static ValueNotifier <List<Categories>> serviceCategories = ValueNotifier <List<Categories>>([]);


  static ValueNotifier <List<AddressModel>> addresses = ValueNotifier <List<AddressModel>>([]);
  static ValueNotifier <List<ProductDetails>> cartList = ValueNotifier <List<ProductDetails>>([]);
  static ValueNotifier <List<ProductDetails>> favList = ValueNotifier <List<ProductDetails>>([]);
  static ValueNotifier<double> orderDeliveryPrice = ValueNotifier <double>(0.0);
  static ValueNotifier<double> orderTax = ValueNotifier <double>(0.0);
  static ValueNotifier<double> orderTotalProductsPrice = ValueNotifier <double>(0.0);
  static ValueNotifier<double> orderTotalPrice = ValueNotifier <double>(0.0);


}