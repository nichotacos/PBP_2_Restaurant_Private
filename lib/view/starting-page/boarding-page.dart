import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pbp_2_restaurant/view/register.dart';

class BoardingPage extends StatefulWidget {
  const BoardingPage({super.key});

  @override
  State<BoardingPage> createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'ssets/ilustrations/ilustration-1.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(
            height: 64,
          ),
          const Text(
            'Select the Favorite Menu',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'subtitle',
              style: TextStyle(color: Colors.green),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 60),
        child: PageView(
          controller: controller,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    'assets/ilustrations/ilustration-1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                    alignment: Alignment.center,
                    width: 300,
                    child: const Text(
                      'Select the Favourites Menu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(72, 0, 72, 0),
                    alignment: Alignment.center,
                    width: 300,
                    child: const Text(
                      'Now we eat well, don\'t leave the house. You can choose your favorite food only with one click.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 59, 59),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(80, 20, 80, 20),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 214, 19, 65),
                      ),
                    ),
                    onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 83),
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    'assets/ilustrations/ilustration-2.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                    alignment: Alignment.center,
                    width: 300,
                    child: const Text(
                      'Good food at a cheap price',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(72, 0, 72, 0),
                    alignment: Alignment.center,
                    width: 300,
                    child: const Text(
                      'You can eat at expensive restaurants with affordable price',
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 59, 59),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(80, 20, 80, 20),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 214, 19, 65),
                      ),
                    ),
                    onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 50),
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    'assets/ilustrations/ilustration-1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                    alignment: Alignment.center,
                    width: 300,
                    child: const Text(
                      'Select the Favourites Menu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(72, 0, 72, 0),
                    alignment: Alignment.center,
                    width: 300,
                    child: const Text(
                      'Now we eat well, don\'t leave the house. You can choose your favorite food only with one click.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 59, 59),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(80, 20, 80, 20),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 214, 19, 65),
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterView(
                            id: null,
                            username: null,
                            email: null,
                            password: null,
                            telephone: null,
                            bornDate: null),
                      ),
                    ),
                    child: const Text(
                      'Start Now',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onPressed: () => controller.jumpToPage(2),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const WormEffect(
                  type: WormType.thin,
                  spacing: 10,
                  activeDotColor: Color.fromARGB(255, 214, 19, 85),
                  dotHeight: 12,
                  dotWidth: 12,
                ),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
            IconButton(
              onPressed: () => controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn),
              icon: const Icon(
                Icons.arrow_forward_outlined,
                color: Color.fromARGB(255, 214, 19, 85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
