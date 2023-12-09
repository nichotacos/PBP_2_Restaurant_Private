import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pbp_2_restaurant/client/transaction_client.dart';
import 'package:pbp_2_restaurant/database/sql_helper_chart.dart';
import 'package:pbp_2_restaurant/view/home.dart';
import 'package:pbp_2_restaurant/view/homePage.dart';
import 'package:pbp_2_restaurant/view/pdf-and-printing/pdf_view.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/model/cart_model.dart';
import 'package:pbp_2_restaurant/client/cart_client.dart';
import 'package:pbp_2_restaurant/main.dart';
import 'package:pbp_2_restaurant/client/transaction_cart_client.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:pbp_2_restaurant/model/transaction_model.dart';
import 'package:pbp_2_restaurant/model/transaction_cart_model.dart';
import 'dart:convert';

class CartPage extends StatefulWidget {
  CartPage({super.key, required this.user});

  User? user;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> carts = [];
  String id = const Uuid().v1();
  File? image;
  double total = 0.0;
  int qty = 0;

  void refresh() async {
    final data = await CartClient.fetchCertain(widget.user!.id);
    setState(() {
      carts = data;
      total = countTotal(carts);
      qty = countQty(carts);
    });
  }

  void onSubmit() async {
    Transactions input = Transactions(
        id: 0,
        review: '',
        status: 'Completed',
        totalAmount: total,
        transactionDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        userId: widget.user!.id ?? 0);

    try {
      if (input.totalAmount == 0.0) throw Exception;
      await TransactionClient.create(input);
      var lastTransaction = await TransactionClient.findLast();

      int lastTrId = lastTransaction;

      for (int i = 0; i < carts.length; i++) {
        await CartClient.changeStatus(carts[i].id);

        var trInput =
            TransactionCart(id: 0, trId: lastTrId, cartId: carts[i].id);

        await TransactionCartClient.create(trInput);
      }

      if (context.mounted) {
        showToast(context, 'Order Completed', Colors.green, Icons.check);
        await Future.delayed(const Duration(seconds: 2));

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(user: widget.user!, pageIndex: 0),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showToast(context, e.toString(), Colors.red, Icons.close);
        await Future.delayed(const Duration(seconds: 2));
        // print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    refresh(); // Panggil refresh saat halaman dimuat
  }

  double countTotal(List<Cart> carts) {
    double temp = 0.0;
    for (int i = 0; i < carts.length; i++) {
      temp += carts[i].totalPrice;
    }

    return temp;
  }

  int countQty(List<Cart> carts) {
    int temp = 0;
    for (int i = 0; i < carts.length; i++) {
      temp += carts[i].quantity;
    }

    return temp;
  }

  void onDelete(id, context) async {
    try {
      await CartClient.destroy(id);
      refresh();
      showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 80, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order List',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 410,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: carts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Image.asset(carts[index].itemImage ?? '', height: 90),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                carts[index].itemName ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text('Quantity: '),
                                  Text(
                                    carts[index].quantity.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const Text(' pax'),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Rp ${carts[index].totalPrice.toString()}0',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 214, 19, 85),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 214, 19, 85),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Items',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Sub-Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              qty.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Rp ${total.toString()}0',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 2.0,
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Place My Order',
                          style: TextStyle(
                            color: Color.fromARGB(255, 214, 19, 85),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // ListView.builder(
      //   itemCount: carts.length,

      //   itemBuilder: (context, index) {
      //     return
      //     // return ListTile(
      //     //   title: Text(carts[index].itemName ?? ''),
      //     // );
      //   },
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     // await createPdf(
      //     //   widget.user!.username.toString(),
      //     //   widget.user!.telephone.toString(),
      //     //   widget.user!.email.toString(),
      //     //   id,
      //     //   widget.user!.imageData.toString(),
      //     //   context,
      //     //   chart[0]['name'].toString(),
      //     //   chart[0]['quantity'].toString(),
      //     //   chart[0]['price'].toString(),
      //     // );
      //     // setState(() {
      //     //   const uuid = Uuid();
      //     //   id = uuid.v1();
      //     // });
      //   },
      //   label: const Text('Get Invoice'),
      //   icon: const Icon(Icons.add),
      // ),
    );
  }
}
