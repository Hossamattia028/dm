import 'package:dmarketing/repository/chat/stories.dart';
import 'package:dmarketing/repository/store/categories.dart';
import 'package:dmarketing/repository/store/fav_cart.dart';
import 'package:dmarketing/repository/store/order.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:dmarketing/pages/merchant/all_market_products.dart';
import 'package:dmarketing/repository/aboutPagesProvider.dart';
import 'package:dmarketing/repository/market/auth_merchant.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:dmarketing/repository/market/market_categories.dart';
import 'package:dmarketing/repository/market/market_order.dart';

class ProvidersList {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider(create: (context) => UserAuth()),
    ChangeNotifierProvider(create: (context) => MerchantAuth()),
    ChangeNotifierProvider(create: (context) => About()),
    ChangeNotifierProvider(create: (context) => MarketCategoriesProvider()),
    ChangeNotifierProvider(create: (context) => MarketOrder()),
    ChangeNotifierProvider(create: (context) => MerchantAuth()),

    ChangeNotifierProvider(create: (context) => CategoriesProvider()),
    ChangeNotifierProvider(create: (context) => FavAndCart()),
    ChangeNotifierProvider(create: (context) => Order()),
    ChangeNotifierProvider(create: (context) => StoriesProvider()),
  ];
}