import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_2_restaurant/client/transaction_client.dart';
import 'package:pbp_2_restaurant/model/transaction_cart_model.dart';
import 'package:pbp_2_restaurant/view/home.dart';
import 'package:pbp_2_restaurant/view/homePage.dart';
import 'package:pbp_2_restaurant/view/pdf-and-printing/pdf_view.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/model/cart_model.dart';
import 'package:pbp_2_restaurant/client/cart_client.dart';
import 'package:pbp_2_restaurant/main.dart';
import 'package:uuid/uuid.dart';
import 'package:pbp_2_restaurant/model/transaction_model.dart';
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  HistoryPage({super.key, required this.user});

  User? user;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Cart> carts = [];
  List<Transactions> transactions = [];
  String id = const Uuid().v1();
  File? image;
  double total = 0.0;
  int qty = 0;
  TextEditingController reviewControl = TextEditingController();

  void refresh() async {
    // final data = await CartClient.fetchCertain(widget.user!.id);
    final data = await TransactionClient.fetchCertain(widget.user!.id);
    setState(() {
      transactions = data;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh(); // Panggil refresh saat halaman dimuat
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

  void onSubmit() async {}

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
                'History',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 680,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 214, 19, 85),
                            width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Transaction ID: ${transactions[index].id.toString()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Date: ${transactions[index].transactionDate}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Text(
                                'Total Amount: Rp ${transactions[index].totalAmount.toString()}0',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Review: ${transactions[index].review}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Add Review'),
                                        content: Form(
                                          // key: _formKey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: reviewControl,
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  try {
                                                    Transactions update =
                                                        Transactions(
                                                            id: transactions[
                                                                    index]
                                                                .id,
                                                            userId:
                                                                transactions[
                                                                        index]
                                                                    .userId,
                                                            status:
                                                                transactions[
                                                                        index]
                                                                    .status,
                                                            transactionDate:
                                                                transactions[
                                                                        index]
                                                                    .transactionDate,
                                                            review:
                                                                reviewControl
                                                                    .text,
                                                            totalAmount:
                                                                transactions[
                                                                        index]
                                                                    .totalAmount);
                                                    await TransactionClient
                                                        .update(update);

                                                    refresh();

                                                    if (context.mounted) {
                                                      Navigator.pop(context);

                                                      showSnackBar(
                                                        context,
                                                        "Review Added",
                                                        Colors.green,
                                                      );
                                                    }
                                                  } catch (e) {
                                                    showSnackBar(
                                                        context,
                                                        e.toString(),
                                                        Colors.red);
                                                  }
                                                },
                                                child: Text('Save'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text('Review'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 214, 19, 85),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Invoice'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 214, 19, 85),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Details'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 214, 19, 85),
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
            ],
          ),
        ),
      ),
      // ListView.builder(
      //   itemCount: transactions.length,

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
