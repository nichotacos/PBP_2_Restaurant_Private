import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pbp_2_restaurant/database/sql_helper.dart';
import 'package:pbp_2_restaurant/constant/app_constant.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pbp_2_restaurant/qr_scan/scanner_error_widget.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';

class BarcodeScannerPageView extends StatefulWidget {
  const BarcodeScannerPageView({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  State<BarcodeScannerPageView> createState() => _BarcodeScannerPageViewState();
}

class _BarcodeScannerPageViewState extends State<BarcodeScannerPageView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcodeCapture;
  late int totalPoints = widget.user!.poin!;

  Future<void> refresh(int currentPoint) async {
    setState(() {
      widget.user!.poin = currentPoint;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: cameraView(),
          ),
          Container(
            height: 50,
            color: Colors.white, // Latar belakang putih
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.monetization_on), // Tambahkan ikon koin
                      Text(
                        'Total Points: ${widget.user!.poin}', // Tampilkan total poin
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: FittedBox(
                      child: GestureDetector(
                        onTap: () => getURLResult(),
                        child: barcodeCaptureTextResult(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cameraView() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            MobileScanner(
              startDelay: true,
              controller: MobileScannerController(torchEnabled: false),
              fit: BoxFit.contain,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              onDetect: (capture) => setBarcodeCapture(capture),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: FittedBox(
                          child: GestureDetector(
                            onTap: () => getURLResult(),
                            child: barcodeCaptureTextResult(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Text barcodeCaptureTextResult(BuildContext context) {
    return Text(
      barcodeCapture?.barcodes.first.rawValue ??
          LabelTextConstant.scanQrPlaceHolderLabel,
      overflow: TextOverflow.fade,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: Colors.white),
    );
  }

  void setBarcodeCapture(BarcodeCapture capture) {
    setState(() {
      barcodeCapture = capture;
    });
  }

  void getURLResult() {
    final qrCode = barcodeCapture?.barcodes.first.rawValue;
    if (qrCode != null) {
      if (qrCode == "https://github.com/nichotacos/PBP_2_Restaurant.git") {
        incrementPoin(3);
      }
      copyToClipboard(qrCode);
    }
  }

  Future<void> incrementPoin(int points) async {
    final user = await SQLHelper.getCertainUser(widget.user!.id);
    if (user != null) {
      final currentPoin = user.poin ?? 0;
      final newPoin = currentPoin + points;
      await SQLHelper.editPoin(
        user.id!,
        newPoin,
      );
      setState(() {
        user.poin = newPoin; // Perbarui totalPoints saat poin bertambah
      });
      refresh(newPoin);
    }
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(LabelTextConstant.txtonCopyingClipBoard)),
    );
  }
}
