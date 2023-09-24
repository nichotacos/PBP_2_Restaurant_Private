import 'package:flutter/material.dart';

class MyGridView extends StatefulWidget {
  const MyGridView({super.key});
  @override
  State<MyGridView> createState() => _MyGridViewState();

}



class _MyGridViewState extends State<MyGridView> {

  List<bool> isExpandedList = [false, false, false, false];


  final double defaultSize = 150.0; // Ukuran default gambar

  final double clickedSize = 200.0; // Ukuran gambar saat diklik

  final double horizontalSpacing = 50; // Jarak horizontal

  final double verticalSpacing = 10; // Jarak vertikal

 

  @override

  Widget build(BuildContext context) {

    return Column(

      mainAxisAlignment: MainAxisAlignment.end,

      children: [

        Column(

          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Container(

              decoration: BoxDecoration(

                color: Colors.white, // Warna latar belakang banner

              ),

              padding: EdgeInsets.all(10.0),

              child: Row(

                children: [

                  SizedBox(width: 10.0), // Jarak antara ikon dan teks

                  Text(

                    'ALL DISCOUNTS ', // Teks banner

                    style: TextStyle(

                      color: Colors.black, // Warna teks banner

                      fontSize: 20.0,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  Icon(

                    Icons.arrow_circle_down, // Icon yang Anda inginkan

                    size: 24.0, // Ukuran ikon

                    color: Colors.black, // Warna ikon

                  ),

                ],

              ),

            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                buildExpandedImage(0, 'images/images1.jpg'),

                SizedBox(width: horizontalSpacing), // Jarak horizontal antar gambar

                buildExpandedImage(1, 'images/images2.jpg'),

              ],

            ),

  

          ],

        ),

      ],

    );

  }

  Widget buildExpandedImage(int index, String imagePath) {

    return GestureDetector(

      onTap: () {

        setState(() {

          isExpandedList[index] = !isExpandedList[index];

        });

      },

      child: Hero(

        tag: imagePath, // Gunakan path gambar sebagai tag hero

        child: AnimatedContainer(

          duration: Duration(milliseconds: 300),

          curve: Curves.easeInOut,

          width: isExpandedList[index] ? clickedSize : defaultSize,

          height: isExpandedList[index] ? clickedSize : defaultSize,

          child: Image.asset(

            imagePath,

            fit: BoxFit.cover,

          ),

        ),

      ),

    );

  }

}