import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:pbp_2_restaurant/model/chart.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:pbp_2_restaurant/view/pdf-and-printing/preview_screen.dart';
import 'package:pbp_2_restaurant/view/pdf-and-printing/custom_row.dart';
import 'package:pbp_2_restaurant/view/pdf-and-printing/get_total_invoice.dart';
import 'package:pbp_2_restaurant/view/pdf-and-printing/item_doc.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> createPdf(
  String nameController,
  String phoneController,
  String emailController,
  String id,
  String base64Image,
  BuildContext context,
  List<toChart> soldProducts,
) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final imageLogo =
      (await rootBundle.load("assets/ilustrations/ilustration-1.png"))
          .buffer
          .asUint8List();
  final imageInvoice = pw.MemoryImage(imageLogo);

  pw.ImageProvider pdfImageProvider(Uint8List imageBytes) {
    return pw.MemoryImage(imageBytes);
  }

  // final imageBytes = base64Image.readAsBytesSync();

  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
            width: 10,
          ),
        ),
      );
    },
  );

  final List<CustomRow> elements = [
    CustomRow('Item Name', 'Item Price', 'Amount', 'Sub Total Products'),
    for (var product in soldProducts)
      CustomRow(
        product.name!,
        product.price!.toString(),
        product.quantity!.toString(),
        (product.price! * product.quantity!).toStringAsFixed(2),
      ),
    CustomRow('Total', '', '', 'Rp ${getSubTotal(soldProducts)}'),
  ];
  pw.Widget table = itemColumn(elements);

  doc.addPage(
    pw.MultiPage(
        pageTheme: pdfTheme,
        header: (pw.Context context) {
          return headerPDF();
        },
        build: (pw.Context context) {
          return [
            pw.Center(
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                  pw.Container(
                    margin:
                        pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  pw.Image(pw.MemoryImage(base64Decode(base64Image))),
                  personalDataFromInput(
                      nameController, phoneController, emailController),
                  pw.SizedBox(height: 100),
                  topOfInvoice(imageInvoice),
                  barcodeGaris(id),
                  pw.SizedBox(height: 50),
                  contentOfInvoice(table),
                  barcodeKotak(id),
                  pw.SizedBox(height: 10),
                ]))
          ];
        },
        footer: (pw.Context context) {
          return pw.Container(
            color: PdfColor.fromHex('#FFBD59'),
            child: footerPDF(formattedDate),
          );
        }),
  );

  if (context.mounted) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ),
    );
  }
}

pw.Header headerPDF() {
  return pw.Header(
    margin: pw.EdgeInsets.zero,
    outlineColor: PdfColors.amber50,
    outlineStyle: PdfOutlineStyle.normal,
    level: 5,
    decoration: pw.BoxDecoration(
      shape: pw.BoxShape.rectangle,
      gradient: pw.LinearGradient(
        colors: [
          PdfColor.fromHex('#FCDF8A'),
          PdfColor.fromHex('#F38381'),
        ],
        begin: pw.Alignment.topLeft,
        end: pw.Alignment.bottomRight,
      ),
    ),
    child: pw.Center(
      child: pw.Text(
        '- Modul 8 Library -',
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 120,
        ),
      ),
    ),
  );
}

pw.Padding imageFromInput(
    pw.ImageProvider Function(Uint8List imageBytes) pdfImageProvider,
    Uint8List imageBytes) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: pw.FittedBox(
      child: pw.Image(pdfImageProvider(imageBytes), width: 330),
      fit: pw.BoxFit.fitHeight,
      alignment: pw.Alignment.center,
    ),
  );
}

pw.Padding personalDataFromInput(
    String nameController, String phoneController, String addressController) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(
      horizontal: 50,
      vertical: 10,
    ),
    child: pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: pw.Text(
                'Name',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: pw.Text(
                nameController,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: pw.Text(
                'Phone Number',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: pw.Text(
                phoneController,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: pw.Text(
                'Email',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: pw.Text(
                addressController,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

pw.Padding topOfInvoice(pw.MemoryImage imageInvoice) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Image(imageInvoice, height: 30, width: 30),
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.Container(
                height: 10,
                decoration: const pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                  color: PdfColors.amberAccent,
                ),
                padding: const pw.EdgeInsets.only(
                  left: 40,
                  top: 10,
                  bottom: 10,
                  right: 40,
                ),
                alignment: pw.Alignment.centerLeft,
                child: pw.DefaultTextStyle(
                  style: const pw.TextStyle(
                    color: PdfColors.amber100,
                    fontSize: 12,
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Our Cinema',
                        style: const pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.blue800,
                        ),
                      ),
                      // Add other Text widgets here
                    ],
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

pw.Padding contentOfInvoice(pw.Widget table) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Column(
      children: [
        pw.Text(
            'Dear Customer, thank you for buying our product, we hope the products can make your day.'),
        pw.SizedBox(height: 30),
        table,
        pw.Text('Thanks for your trust and till the next time'),
        pw.SizedBox(height: 30),
        pw.Text('Kind Regards'),
        pw.SizedBox(height: 30),
        pw.Text('XXXX'),
      ],
    ),
  );
}

pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: pw.Center(
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: id,
        width: 150,
        height: 150,
      ),
    ),
  );
}

pw.Container barcodeGaris(String id) {
  return pw.Container(
    child: pw.Padding(
      padding: pw.EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: pw.BarcodeWidget(
        barcode: Barcode.code128(escapes: true),
        data: id,
        width: 100,
        height: 50,
      ),
    ),
  );
}

pw.Center footerPDF(String formattedDate) => pw.Center(
      child: pw.Text(
        'Created At $formattedDate',
        style: pw.TextStyle(fontSize: 100, color: PdfColors.blue),
      ),
    );
