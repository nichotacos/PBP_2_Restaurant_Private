import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_2_restaurant/appBar/appbarView.dart';
import 'package:pbp_2_restaurant/database/sql_helper_chart.dart';

class itemPageFrenchFries extends StatefulWidget {
  const itemPageFrenchFries(
      {super.key,
      required this.id,
      required this.name,
      required this.quantity,
      required this.id_user});
  final String? name;
  final int? id, quantity, id_user;
  @override
  State<itemPageFrenchFries> createState() => _itemPageFrenchFriesState();
}

class _itemPageFrenchFriesState extends State<itemPageFrenchFries> {
  TextEditingController controllerQuantity = TextEditingController();
  void incrementCounter() {
    setState(() {
      int counter = int.parse(controllerQuantity.text);
      counter++;
      controllerQuantity.text = counter.toString();
    });
  }

  void decrementCounter() {
    setState(() {
      int counter = int.parse(controllerQuantity.text);
      if (counter > 1) {
        counter--;
        controllerQuantity.text = counter.toString();
      }
    });
  }

  var x = 0;
  var y = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.id != null && y == 0) {
      controllerQuantity.text = widget.quantity.toString();
      y = 1;
    } else if (x == 0 && y == 0) {
      controllerQuantity.text = "1";
      x = 1;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ListView(
          children: [
            appBarView(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                "assets/images/appBarView_images/FrenchFries.jpeg",
                height: 300,
                width: double.infinity,
              ),
            ),
            Arc(
              edge: Edge.TOP,
              arcType: ArcType.CONVEY,
              height: 30,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.red,
                              ),
                              onRatingUpdate: (index) {},
                            ),
                            const Text(
                              "\Rp100.000",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 20,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "French Fries",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 120,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      decrementCounter();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    controllerQuantity.text,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      incrementCounter();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          "French fries are a beloved, crispy snack that hails from the United States but has become a global sensation. These golden, deep-fried potato strips are typically seasoned with salt, making them the perfect combination of crispy on the outside and tender on the inside. French fries are a classic accompaniment to burgers, hot dogs, and other fast-food favorites, but they're also enjoyed as a standalone treat. Their irresistible taste and addictive crunch make them a popular choice for people of all ages.",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Time:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(
                                    CupertinoIcons.clock,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  "30 Minutes",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "\Rp100.000",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (widget.id == null) {
                    await addToChart();
                  } else {
                    await editChart(widget.id!);
                  }
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 15,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                icon: Icon(CupertinoIcons.cart),
                label: Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addToChart() async {
    await SQLHelper.addToChart(
        "French Fries",
        int.parse(controllerQuantity.text),
        "assets/images/Snack.png",
        "The Best French Fries in the world",
        10,
        1);
  }

  Future<void> editChart(int id) async {
    await SQLHelper.editChart(
        id,
        "French Fries",
        int.parse(controllerQuantity.text),
        "assets/images/Snack.png",
        "French Fries in the world",
        10,
        1);
  }
}
