import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewestItemView extends StatelessWidget {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10, 
          horizontal: 10
        ),
        child: Column(
          children: [
            // First Item
            // for (int i=0; i<10; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,         // Ukuran Container Newest
                height: 150,        // Ukuran Container Newest
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/Pizza.jpeg",
                          height: 150,
                          width: 175,
                        ),
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Pizza",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Taste Our Pizza, We Provide Our Great Foods ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star, 
                              color: Colors.red
                            ), 
                            onRatingUpdate: (index) {},
                          ),

                          Text(
                            "\Rp 50.000", 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 20, 
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.red,
                            size: 20, 
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

                        Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,         // Ukuran Container Newest
                height: 150,        // Ukuran Container Newest
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/Burger.jpeg",
                          height: 150,
                          width: 175,
                        ),
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Burger",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Taste Our Pizza, We Provide Our Great Foods ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star, 
                              color: Colors.red
                            ), 
                            onRatingUpdate: (index) {},
                          ),

                          Text(
                            "\Rp 50.000", 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 20, 
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.red,
                            size: 20, 
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

                        Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,         // Ukuran Container Newest
                height: 150,        // Ukuran Container Newest
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/FrenchFries.jpeg",
                          height: 150,
                          width: 175,
                        ),
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "French Fries",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Taste Our Pizza, We Provide Our Great Foods ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star, 
                              color: Colors.red
                            ), 
                            onRatingUpdate: (index) {},
                          ),

                          Text(
                            "\Rp 50.000", 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 20, 
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.red,
                            size: 20, 
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

                        Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,         // Ukuran Container Newest
                height: 150,        // Ukuran Container Newest
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/Spaghetti.jpeg",
                          height: 150,
                          width: 175,
                        ),
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Spaghetti",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Taste Our Pizza, We Provide Our Great Foods ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star, 
                              color: Colors.red
                            ), 
                            onRatingUpdate: (index) {},
                          ),

                          // Harga
                          Text(
                            "\Rp 50.000", 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Icon buat belanja
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 20, 
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.red,
                            size: 20, 
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}