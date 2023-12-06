import 'package:flutter/material.dart';
// import 'package:pbp_2_restaurant/view/menu/itemPageBurger.dart';
// import 'package:pbp_2_restaurant/view/menu/itemPageFrenchFries.dart';
// import 'package:pbp_2_restaurant/view/menu/itemPageSpaghetti.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/view/menu/item_page.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Row(
          children: [
            // Single Item
            // for (int i=0; i<10; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: InkWell(
                key: const Key('BurgerPage'),
                // onTap: () {},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemPage(
                        itemId: 1,
                        user: user,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 225,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/burger/cheeseburger-deluxe.png",
                              height: 100,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Cheeseburger Deluxe",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "100 gr chicken + tomato + cheese Lettuce",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 14),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rp 25.000",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: InkWell(
                onTap: () {},
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => itemPageSpaghetti(
                //         id: null,
                //         name: null,
                //         quantity: null,
                //         id_user: null,
                //       ),
                //     ),
                //   );
                // },
                child: Container(
                  width: 200,
                  height: 225,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/appBarView_images/Spaghetti.jpeg",
                            height: 120,
                          ),
                        ),
                        const Text(
                          "SPAGHETTI",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Komposisi: Italian Spaghetti Noodles, Sausage, Parsley Leaves",
                          style: TextStyle(
                            fontSize: 10,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 9),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\Rp 35.000",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 25,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: InkWell(
                onTap: () {},
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => itemPageFrenchFries(
                //         id: null,
                //         name: null,
                //         quantity: null,
                //         id_user: null,
                //       ),
                //     ),
                //   );
                // },
                child: Container(
                  width: 200,
                  height: 225,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/appBarView_images/FrenchFries.jpeg",
                            height: 120,
                          ),
                        ),
                        const Text(
                          "FRENCH FRIES",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Komposisi: French Fries, Sauce (Spicy / Sweet / Spicy and Sweet) ",
                          style: TextStyle(
                            fontSize: 10,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 9),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\Rp 20.000",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 25,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
