import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatelessWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Latar belakang merah
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'My QR Code', // Judul di atas QR code
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            QrImageView(
              data: 'https://github.com/nichotacos/PBP_2_Restaurant.git',
              version: 6,
              padding: const EdgeInsets.all(50),
            ),
          ],
        ),
      ),
    );
  }
}
