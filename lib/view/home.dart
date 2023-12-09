import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/burger_grid.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/main.dart';
import 'package:pbp_2_restaurant/view/cart.dart';
import 'package:pbp_2_restaurant/view/history.dart';
import 'package:pbp_2_restaurant/view/homePage.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbp_2_restaurant/QRView/QrCamera.dart';

/// Flutter code sample for [NavigationBar].

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.user, required this.pageIndex});

  final User user;
  final int pageIndex;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // int currentPageIndex = widget.pageIndex;
  int currentPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int currentPageIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 207, 207, 207),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Orders',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        HomePage(logUser: widget.user),
        CartPage(
          user: widget.user,
        ),
        HistoryPage(user: widget.user),
        ProfilePage(user: widget.user),
      ][currentPageIndex],
    );
  }
}
