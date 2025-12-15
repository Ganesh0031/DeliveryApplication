import 'package:currency_converter/Screens/HomeScreen.dart';
import 'package:currency_converter/Screens/MyCartScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/CartController.dart';

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _selectedIndex = 0;

  final CartController cartController = Get.find<CartController>();

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyCartScreen(),
    Center(child: Text("Wishlist")),
    Center(child: Text("History")),
    Center(child: Text("Profile")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        items: [
          /// HOME
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0
                  ? Icons.home
                  : Icons.home_outlined,
              size: 28,
            ),
            label: "",
          ),

          /// CART WITH BADGE ⭐
          BottomNavigationBarItem(
            icon: Obx(() {
              return cartBadge(
                count: cartController.totalItems,
                icon: Icon(
                  _selectedIndex == 1
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  size: 28,
                ),
              );
            }),
            label: "",
          ),

          /// WISHLIST
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 28,
            ),
            label: "",
          ),

          /// HISTORY
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3
                  ? Icons.history
                  : Icons.history_outlined,
              size: 28,
            ),
            label: "",
          ),

          /// PROFILE
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 4
                  ? Icons.person
                  : Icons.person_outline,
              size: 28,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}

Widget cartBadge({required Widget icon, required int count}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      icon,
      if (count > 0)
        Positioned(
          right: -6,
          top: -4,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
    ],
  );
}
