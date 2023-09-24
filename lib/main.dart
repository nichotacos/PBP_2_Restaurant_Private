import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:pbp_2_restaurant/burger_grid.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
=======
import 'package:pbp_2_restaurant/view/home.dart';
>>>>>>> bca6db5c82cc831ce2ed052f613a25846ae993eb

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Demo"),
          backgroundColor: Colors.red,
        ),
        body: const Center(
          child: BurgerGrid(),
        ),
      ),
=======
    return const MaterialApp(
      home: HomeView(),
>>>>>>> bca6db5c82cc831ce2ed052f613a25846ae993eb
    );
  }
}
