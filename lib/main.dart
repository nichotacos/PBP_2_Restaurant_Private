import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/burger_grid.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
