import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pbp_2_restaurant/appBar/appbarView.dart';
import 'package:pbp_2_restaurant/database/sql_helper_chart.dart';
import 'package:pbp_2_restaurant/client/CartClient.dart';
import 'package:pbp_2_restaurant/main.dart';
import 'package:pbp_2_restaurant/model/chart.dart';
import 'package:pbp_2_restaurant/entity/user.dart';

class itemPageBurger extends StatefulWidget {
  const itemPageBurger(
      {super.key,
      required this.id,
      required this.name,
      required this.quantity,
      required this.user});

  final String? name;
  final int? id, quantity;
  final User user;

  @override
  State<itemPageBurger> createState() => _itemPageBurgerState();
}

class _itemPageBurgerState extends State<itemPageBurger> {
  final _formKey = GlobalKey<FormState>();
  final FlutterTts fLutterTts = FlutterTts();
  TextEditingController controllerQuantity = TextEditingController();
  List<Map<String, dynamic>> chart = [];
  var desc =
      "Savor the Cheeseburger Deluxe, an exquisite blend of flavors and textures. A succulent beef patty, flame-kissed to perfection, harmonizes with melted cheese atop a toasted bun. Crisp lettuce, juicy tomatoes, pickles, and a tangy sauce add layers of freshness and zing. Elevate your burger experience with this culinary masterpiece, marrying classic charm with gourmet finesse—a symphony of taste in every bite.";
  speak(String text) async {
    await fLutterTts.setLanguage("en-US");
    await fLutterTts.setPitch(1);
    await fLutterTts.speak(text);
  }

  void initState() {
    super.initState();
    refresh(); // Panggil refresh saat halaman dimuat
  }

  Future<void> refresh() async {
    final data = await SQLHelper.getChart();
    setState(() {
      chart = data;
    });
  }

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

  var y = 0;
  var x = 0;
  @override
  Widget build(BuildContext context) {
    void onSubmit() async {
      //if (!_formKey.currentState!.validate()) return;
      await fLutterTts.stop();

      toChart input = toChart(
        id: widget.id ?? 0,
        name: "Burger",
        quantity: int.parse(controllerQuantity.text),
        image: "assets/images/burger/cheeseburger-deluxe.png",
        desc: "The Best Beef Burger in the world",
        price: 10,
        id_user: 1,
      );

      try {
        if (widget.id == null) {
          await CartClient.create(input);
        } else {
          await CartClient.update(input);
        }

        showSnackBar(context, 'Success', Colors.green);
        Navigator.pop(context);
      } catch (err) {
        showSnackBar(context, err.toString(), Colors.red);
        Navigator.pop(context);
      }
    }

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
                "assets/images/burger/cheeseburger-deluxe.png",
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
                              "Cheeseburger \nDeluxe",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.volume_up),
                              onPressed: () => speak(desc),
                            ),
                            const SizedBox(width: 40),
                            Container(
                              width: 120,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    key: const Key('DecrementOrder'),
                                    onPressed: () {
                                      decrementCounter();
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    key: const Key('Quantity'),
                                    controllerQuantity.text,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    key: const Key('IncrementOrder'),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Text(
                              desc,
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.justify,
                            ),
                          ],
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
              const Row(
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
                key: const Key('AddtoCart'),
                onPressed: onSubmit,
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
        "Burger",
        int.parse(controllerQuantity.text),
        "assets/images/burger/beef-burger.png",
        "The Best Beef Burger in the world",
        10,
        1);
  }

  Future<void> editChart(int id) async {
    await SQLHelper.editChart(
        id,
        "Burger",
        int.parse(controllerQuantity.text),
        "assets/images/burger/beef-burger.png",
        "The Best Beef Burger in the world",
        10,
        1);
  }
}
