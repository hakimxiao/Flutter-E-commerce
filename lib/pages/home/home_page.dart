import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/cart/cart_history.dart';
import 'package:flutter_ecommerce/pages/cart/cart_page.dart';
import 'package:flutter_ecommerce/pages/home/main_food_page.dart';
import 'package:flutter_ecommerce/utils/colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Navigation Bar Demo',
      home: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: MainFoodPage(),
            item: ItemConfig(
              icon: Icon(Icons.home_filled),
              inactiveIcon: Icon(Icons.home_outlined),
              title: "Home",
              activeForegroundColor: Colors.black54,
              activeColorSecondary: AppColors.mainColor,
            ),
          ),
          PersistentTabConfig(
            screen: SizedBox(child: CartHistory()),
            item: ItemConfig(
              icon: Icon(Icons.archive),
              inactiveIcon: Icon(Icons.archive_outlined),
              title: "History",
              activeForegroundColor: Colors.black54,
              activeColorSecondary: AppColors.mainColor,
            ),
          ),
          PersistentTabConfig(
            screen: CartPage(),
            item: ItemConfig(
              icon: Icon(Icons.shopping_cart),
              inactiveIcon: Icon(Icons.shopping_cart_outlined),
              title: "Cart",
              activeForegroundColor: Colors.black54,
              activeColorSecondary: AppColors.mainColor,
            ),
          ),
          PersistentTabConfig(
            screen: SizedBox(child: Center(child: Text('Next Page 4'))),
            item: ItemConfig(
              icon: Icon(Icons.person),
              inactiveIcon: Icon(Icons.person_outline),
              title: "Me",
              activeForegroundColor: Colors.black54,
              activeColorSecondary: AppColors.mainColor,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style8BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
