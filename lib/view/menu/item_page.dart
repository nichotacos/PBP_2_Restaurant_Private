import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pbp_2_restaurant/appBar/appbarView.dart';
import 'package:pbp_2_restaurant/database/sql_helper_chart.dart';
import 'package:pbp_2_restaurant/client/cart_client.dart';
import 'package:pbp_2_restaurant/client/item_client.dart';
import 'package:pbp_2_restaurant/main.dart';
import 'package:pbp_2_restaurant/model/cart_model.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/entity/item.dart';
import 'package:pbp_2_restaurant/main.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, required this.itemId, required this.user});

  final User user;
  final int itemId;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final _formKey = GlobalKey<FormState>();
  final FlutterTts fLutterTts = FlutterTts();
  TextEditingController controllerQuantity = TextEditingController();

  String itemName = '';
  double itemPrice = 0.0;
  String itemDescription = '';
  String itemImage = '';
  int quantity = 0;
  double total = 0.0;

  speak(String text) async {
    await fLutterTts.setLanguage("en-US");
    await fLutterTts.setPitch(1);
    await fLutterTts.speak(text);
  }

  void refresh() async {
    final itemData = await ItemClient.find(widget.itemId);
    final cartData = await CartClient.checkZeroQty(widget.itemId);
    Cart? foundCart;

    if (!cartData) {
      foundCart = await CartClient.findCart(widget.itemId);
    }

    setState(() {
      itemName = itemData.name ?? '';
      itemPrice = itemData.price ?? 0.0;
      itemDescription = itemData.description ?? '';
      itemImage = itemData.imageData ?? '';
      if (cartData) {
        controllerQuantity.text = "0";
        total = 0.0;
      } else {
        controllerQuantity.text = foundCart!.quantity.toString();
        total = (itemPrice * foundCart.quantity).toDouble();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  void incrementCounter() {
    setState(() {
      int counter = int.parse(controllerQuantity.text);
      counter++;
      total = (itemPrice * counter).toDouble();
      controllerQuantity.text = counter.toString();
      quantity = counter;
    });
  }

  void decrementCounter() {
    setState(() {
      int counter = int.parse(controllerQuantity.text);
      if (counter > 0) {
        counter--;
        total = (itemPrice * counter).toDouble();
        controllerQuantity.text = counter.toString();
        quantity = counter;
      }
    });
  }

  var y = 0;
  var x = 0;

  @override
  Widget build(BuildContext context) {
    void onSubmit() async {
      await fLutterTts.stop();

      try {
        var availCart = await CartClient.findAvail(widget.itemId);

        Cart input = Cart(
            id: 0,
            itemId: widget.itemId,
            quantity: quantity,
            totalPrice: total,
            userId: widget.user.id!,
            status: "On progress");

        if (availCart == false) {
          await CartClient.create(input);

          if (context.mounted) {
            showToast(context, "Added to cart", Colors.green, Icons.check);
            await Future.delayed(const Duration(seconds: 2));
          }
        } else {
          var foundCart = await CartClient.findCart(widget.itemId);
          Cart update = Cart(
            id: foundCart.id,
            itemId: widget.itemId,
            userId: widget.user.id!,
            quantity: quantity,
            totalPrice: total,
            status: "On progress",
          );
          await CartClient.update(update);

          if (context.mounted) {
            showToast(
                context, "Cart updated", Colors.orangeAccent, Icons.check);
            await Future.delayed(const Duration(seconds: 2));
          }
        }
      } catch (e) {
        throw ('Error: ${e.toString()}');
      }
    }

    if (widget.user.id != null && y == 0) {
      controllerQuantity.text = quantity.toString();
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
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 50,
                width: 50,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(40, 255, 0, 0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      CupertinoIcons.back,
                      color: const Color.fromARGB(1000, 255, 0, 0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                itemImage,
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
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (index) {},
                            ),
                            Text(
                              "Rp ${itemPrice.toString()}0",
                              style: const TextStyle(
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
                            Container(
                              width: 160,
                              child: Text(
                                itemName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.volume_up),
                              onPressed: () => speak(itemDescription),
                            ),
                            const SizedBox(width: 35),
                            Container(
                              width: 125,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 214, 19, 85),
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
                                    icon: const Icon(
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
                              itemDescription,
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
                                    color: Color.fromARGB(255, 214, 19, 85),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Rp ${total.toString()}0",
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 214, 19, 85)),
                  ),
                ],
              ),
              ElevatedButton.icon(
                key: const Key('AddtoCart'),
                onPressed: onSubmit,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 214, 19, 85)),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 15,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                icon: const Icon(CupertinoIcons.cart),
                label: const Text(
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
}
