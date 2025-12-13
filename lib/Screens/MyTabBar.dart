import 'package:currency_converter/Screens/HomeScreen.dart';
import 'package:currency_converter/Screens/MyCartScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
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

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          elevation: 0,

          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,

          showSelectedLabels: false,
          showUnselectedLabels: false,

          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                size: 28,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 1
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                size: 28,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 2
                    ? Icons.favorite
                    : Icons.favorite_border,
                size: 28,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 3
                    ? Icons.history
                    : Icons.history_outlined,
                size: 28,
              ),
              label: "",
            ),
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
      ),
    );
  }
}
