import 'package:flutter_ecommerce/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce/controllers/recommended_product_controller.dart';
import 'package:flutter_ecommerce/data/api/api_client.dart';
import 'package:flutter_ecommerce/data/repository/popular_product_repo.dart';
import 'package:flutter_ecommerce/data/repository/recommended_product_repo.dart';
import 'package:flutter_ecommerce/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
    () => RecommendedProductController(recommendedProductRepo: Get.find()),
  );
}
