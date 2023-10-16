import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pbp_2_restaurant/appBar/appbarView.dart';
import 'package:pbp_2_restaurant/database/sql_helper_chart.dart';
import 'package:pbp_2_restaurant/view/menu/itemPageBurger.dart';
import 'package:pbp_2_restaurant/view/menu/itemPageFrenchFries.dart';
import 'package:pbp_2_restaurant/view/menu/itemPagePizza.dart';
import 'package:pbp_2_restaurant/view/menu/itemPageSpaghetti.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> chart = [];
  void refresh() async {
    final data = await SQLHelperChart.getChart();
    setState(() {
      chart = data;
    });
  }

  void incrementCounter(int index) {
    setState(() {
      int counter = chart[index]['quantity'];
      counter++;
      chart[index]['quantity'] = counter;
    });
  }

  void decrementCounter(int index) {
    setState(() {
      int counter = chart[index]['quantity'];
      if (counter > 1) {
        counter--;
        chart[index]['quantity'] = counter;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: chart.length,
          itemBuilder: (context, index) {
            return Slidable(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 9),
                  child: Container(
                    width: 380,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(chart[index]['image'],
                              height: 80, width: 150),
                        ),
                        Container(
                          width: 190,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  chart[index]['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  chart[index]['desc'],
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "\$" + chart[index]['price'].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: 40,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: [
                              IconButton(
                                onPressed: () {
                                  incrementCounter(index);
                                },
                                icon: Icon(
                                  CupertinoIcons.plus,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                chart[index]['quantity'].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  decrementCounter(index);
                                },
                                icon: Icon(
                                  CupertinoIcons.minus,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                actionPane: SlidableBehindActionPane(),
                secondaryActions: [
                  IconSlideAction(
                    caption: 'Update',
                    color: Colors.blue,
                    icon: Icons.update,
                    onTap: () async {
                      if (chart[index]['name'] == "Burger") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => itemPageBurger(
                                    id: chart[index]['id'],
                                    name: chart[index]['name'],
                                    quantity: chart[index]['quantity'],
                                    id_user: chart[index]['id_user'],
                                  )),
                        ).then((_) => refresh());
                      } else if (chart[index]['name'] == "Spaghetti") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => itemPageSpaghetti(
                                    id: chart[index]['id'],
                                    name: chart[index]['name'],
                                    quantity: chart[index]['quantity'],
                                    id_user: chart[index]['id_user'],
                                  )),
                        ).then((_) => refresh());
                      } else if (chart[index]['name'] == "French Fries") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => itemPageFrenchFries(
                                    id: chart[index]['id'],
                                    name: chart[index]['name'],
                                    quantity: chart[index]['quantity'],
                                    id_user: chart[index]['id_user'],
                                  )),
                        ).then((_) => refresh());
                      }
                    },
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () async {
                      await deleteChart(chart[index]['id']);
                    },
                  )
                ]);
          }),
    ));
  }

  Future<void> deleteChart(int id) async {
    await SQLHelperChart.deleteChart(id);
    refresh();
  }
}
