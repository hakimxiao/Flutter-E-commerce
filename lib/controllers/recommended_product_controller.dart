import 'package:flutter_ecommerce/data/repository/recommended_product_repo.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    //7 37 31
    Response response = await recommendedProductRepo
        .getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(
        ProductsModel.fromJson(response.body).products,
      );
      _isLoaded = true;
      update();
    } else {}
  }
}
