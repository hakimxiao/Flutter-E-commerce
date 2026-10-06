import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce/controllers/recommended_product_controller.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/routes/routes_helper.dart';
import 'package:flutter_ecommerce/utils/app_constants.dart';
import 'package:flutter_ecommerce/utils/colors.dart';
import 'package:flutter_ecommerce/utils/dimensions.dart';
import 'package:flutter_ecommerce/widgets/app_column.dart';
import 'package:flutter_ecommerce/widgets/text/big_text.dart';
import 'package:flutter_ecommerce/widgets/text/icon_and_text.dart';
import 'package:flutter_ecommerce/widgets/text/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Section
        GetBuilder<PopularProductController>(
          builder: (controller) {
            return controller.isLoaded
                ? SizedBox(
                    height: Dimensions.pageView,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.getPopularFood());
                      },
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: controller.popularProductList.length,
                        itemBuilder: (context, position) {
                          return __buildPageItem(
                            position,
                            controller.popularProductList[position],
                          );
                        },
                      ),
                    ),
                  )
                : CircularProgressIndicator(color: AppColors.mainColor);
          },
        ),
        // Dots Section
        GetBuilder<PopularProductController>(
          builder: (controller) {
            return DotsIndicator(
              dotsCount: controller.popularProductList.isEmpty
                  ? 1
                  : controller.popularProductList.length,
              position: _currPageValue.round(),
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: Size.square(9.0),
                activeSize: Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
            );
          },
        ),
        // Popular Section
        SizedBox(height: Dimensions.height10),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: '.', color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing'),
              ),
            ],
          ),
        ),

        // List of foods and images
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) => recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recommendedProduct.recommendedProductList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.recommendedFood);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.height10,
                        ),
                        child: Row(
                          children: [
                            // Image section
                            Container(
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius20,
                                ),
                                color: Colors.white30,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${recommendedProduct.recommendedProductList[index].img!}',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                      Dimensions.radius20,
                                    ),
                                    bottomRight: Radius.circular(
                                      Dimensions.radius20,
                                    ),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsGeometry.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                        text: recommendedProduct
                                            .recommendedProductList[index]
                                            .name!,
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      SmallText(
                                        text: 'With chinese characteristics',
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndText(
                                            icon: Icons.circle_sharp,
                                            text: 'Normal',
                                            iconColor: AppColors.iconColor1,
                                          ),
                                          IconAndText(
                                            icon: Icons.location_on,
                                            text: '1.7Km',
                                            iconColor: AppColors.mainColor,
                                          ),
                                          IconAndText(
                                            icon: Icons.access_time_rounded,
                                            text: '31Min',
                                            iconColor: AppColors.iconColor2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(color: AppColors.mainColor),
        ),
      ],
    );
  }

  Widget __buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
              left: Dimensions.width10,
              right: Dimensions.width10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${popularProduct.img!}',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.height15,
                  right: Dimensions.height15,
                ),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
