import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/qr_scan/scan_qr_page.dart';
import 'package:pbp_2_restaurant/generate_qr/generate_qr_page.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';

class QRCameraPage extends StatefulWidget {
  const QRCameraPage({super.key, required this.user});
  final User user;
  @override
  _QRCameraPageState createState() => _QRCameraPageState();
}

class _QRCameraPageState extends State<QRCameraPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Camera'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _changePage(index);
        },
        physics: const BouncingScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _changePage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'My QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scan QR',
          ),
        ],
      ),
    );
  }

  // ignore: prefer_final_fields
  late List<Widget> _pages = [
    const GenerateQRPage(),
    BarcodeScannerPageView(user: widget.user),
  ];
}
