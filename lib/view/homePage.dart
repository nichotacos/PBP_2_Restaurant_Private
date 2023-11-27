import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/appBar/appbarView.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/view/CategoriesView.dart';
import 'package:pbp_2_restaurant/view/DrawerView.dart';
import 'package:pbp_2_restaurant/view/NewestView.dart';
import 'package:pbp_2_restaurant/view/PopularView.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.logUser});

  final User logUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // custom appBarView
          appBarView(),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.search,
                      color: Colors.red,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "What do you want to looking for?",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.filter_list),
                  ],
                ),
              ),
            ),
          ),

          // Category
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          // Categories
          const CategoriesView(),

          // Popular Items
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Popular",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          // Popular
          PopularView(user: widget.logUser),

          // Newest Items
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Newest",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),

          // Newest Item View
          NewestItemView(user: widget.logUser),
        ],
      ),
      drawer: DrawerView(user: widget.logUser),
      floatingActionButton: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ]),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            CupertinoIcons.cart,
            size: 30,
            color: Colors.deepOrange,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
