import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.grey[900],
        ),
        title: Text(
          "Sans Kitchen",
          style: TextStyle(color: Colors.grey[900]),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Positioned(child: _buildHighlight()),
            Positioned(child: _buildCategory()),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlight() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage('assets/images/Banner-Home.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              ' Food Category',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              child: InkWell(
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
                ),
              ),
            ),
            Card(
              child: InkWell(
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
            ),
            Card(
                child: InkWell(
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
            ))),
            Card(
                child: InkWell(
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
            ))),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
                child: InkWell(
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
            ))),
            Card(
                child: InkWell(
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
            ))),
            Card(
                child: InkWell(
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
            ))),
            Card(
                child: InkWell(
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
            ))),
          ],
        ),
        Row(
          children: [],
        )
      ],
    );
  }
}
