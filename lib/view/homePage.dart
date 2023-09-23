import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                      child: Column(
                    children: [
                      Container(
                        width: 75,
                        height: 50,
                        child: Image.asset(
                          "assets/images/Humberger.png",
                        ),
                      ),
                      Text(
                        "Hamburger",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                  Card(
                      child: Column(
                    children: [
                      Container(
                        width: 75,
                        height: 50,
                        child: Image.asset(
                          "assets/images/Pizza.png",
                        ),
                      ),
                      Text(
                        "Pizza",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                  Card(
                      child: Column(
                    children: [
                      Container(
                        width: 75,
                        height: 50,
                        child: Image.asset(
                          "assets/images/Noodles.png",
                        ),
                      ),
                      Text(
                        "Noodles",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                  Card(
                      child: Column(
                    children: [
                      Container(
                        width: 75,
                        height: 50,
                        child: Image.asset(
                          "assets/images/Meat.png",
                        ),
                      ),
                      Text(
                        "Meat",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                      child: Column(
                    children: [
                      Container(
                        width: 75,
                        height: 50,
                        child: Image.asset(
                          "assets/images/Salad.png",
                        ),
                      ),
                      Text(
                        "Salad",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                  Card(
                      child: Column(
                    children: [
                      Container(
                        width: 75,
                        height: 50,
                        child: Image.asset(
                          "assets/images/Dessert.png",
                        ),
                      ),
                      Text(
                        "Dessert",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                  Card(
                      child: Column(
                    children: [
                      Container(
                        width: 75,
                        height: 50,
                        child: Image.asset(
                          "assets/images/Snack.png",
                        ),
                      ),
                      Text(
                        "Snack",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                  Card(
                      child: Column(
                    children: [
                      Container(
                        width: 75,
                        height: 50,
                        child: Image.asset(
                          "assets/images/Drink.png",
                        ),
                      ),
                      Text(
                        "Drink",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
