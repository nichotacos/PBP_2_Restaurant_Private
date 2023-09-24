import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/data/burgers.dart';
import 'package:pbp_2_restaurant/models/show_burgers.dart';

class BurgerGrid extends StatefulWidget {
  const BurgerGrid({super.key});

  @override
  State<BurgerGrid> createState() => _BurgerGridState();
}

class _BurgerGridState extends State<BurgerGrid> {
  final int _cells = burgers.length;
  final double _containerSizeSmall = 130;
  final double _containerSizeLarge = 300;
  final double _padding = 20;
  int _clicked = 0;
  bool status = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    //Widget incrementIndex = BurgerGrid(rollIndex);
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 248, 155, 155),
        ),
        padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height,
              width: double.infinity,
              child: Wrap(
                children: List.generate(
                  _cells,
                  (col) => Padding(
                    padding: EdgeInsets.all(_padding),
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            if (_clicked != col + 1) {
                              _clicked = col + 1;
                              status = true;
                            } else {
                              _clicked = 0;
                              status = false;
                            }
                          },
                        );
                      },
                      child: Container(
                        height: _clicked == col + 1
                            ? _containerSizeLarge
                            : _containerSizeSmall,
                        width: _clicked == col + 1
                            ? _containerSizeLarge
                            : _containerSizeSmall,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Image.asset(
                                burgerImages[index].toString(),
                              ),
                            ),
                            Center(
                              child: Text(
                                'burger mekidi',
                                style: status
                                    ? const TextStyle(fontSize: 30)
                                    : const TextStyle(fontSize: 20),
                              ),
                            ),
                            // child: rollIndex(),
                          ],
                        ),
                      ),
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
