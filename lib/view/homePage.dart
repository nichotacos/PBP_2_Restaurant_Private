import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_2_restaurant/burger_grid.dart';

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
        image: const DecorationImage(
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
        const Row(
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
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  const BurgerGrid();
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 50,
                      child: Image.asset(
                        "assets/images/Humberger.png",
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      "Hamburger",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: InkWell(
                  child: Column(
                children: [
                  SizedBox(
                    width: 75,
                    height: 50,
                    child: Image.asset(
                      "assets/images/Pizza.png",
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "Pizza",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 52, 52, 52),
                    ),
                  ),
                ],
              )),
            ),
            Card(
                color: Colors.white,
                child: InkWell(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 50,
                      child: Image.asset(
                        "assets/images/Noodles.png",
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      "Noodles",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                  ],
                ))),
            Card(
                color: Colors.white,
                child: InkWell(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 50,
                      child: Image.asset(
                        "assets/images/Meat.png",
                      ),
                    ),
                    const Text(
                      "Meat",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 52, 52, 52),
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
                color: Colors.white,
                child: InkWell(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 50,
                      child: Image.asset(
                        "assets/images/Salad.png",
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      "Salad",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                  ],
                ))),
            Card(
                color: Colors.white,
                child: InkWell(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 50,
                      child: Image.asset(
                        "assets/images/Dessert.png",
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      "Dessert",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                  ],
                ))),
            Card(
                color: Colors.white,
                child: InkWell(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 50,
                      child: Image.asset(
                        "assets/images/Snack.png",
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      "Snack",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                  ],
                ))),
            Card(
                color: Colors.white,
                child: InkWell(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 50,
                      child: Image.asset(
                        "assets/images/Drink.png",
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      "Drink",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                  ],
                ))),
          ],
        ),
        const Row(
          children: [],
        )
      ],
    );
  }
}
