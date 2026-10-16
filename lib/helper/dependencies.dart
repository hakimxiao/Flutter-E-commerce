import 'package:flutter_ecommerce/controllers/cart_controller.dart';
import 'package:flutter_ecommerce/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce/controllers/recommended_product_controller.dart';
import 'package:flutter_ecommerce/data/api/api_client.dart';
import 'package:flutter_ecommerce/data/repository/cart_repo.dart';
import 'package:flutter_ecommerce/data/repository/popular_product_repo.dart';
import 'package:flutter_ecommerce/data/repository/recommended_product_repo.dart';
import 'package:flutter_ecommerce/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
    () => RecommendedProductController(recommendedProductRepo: Get.find()),
  );
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
