// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:intl/intl.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:pbp_2_restaurant/view/pdf-and-printing/get_total_invoice.dart';
// import 'package:pbp_2_restaurant/view/pdf-and-printing/custom_row.dart';
// import 'package:pbp_2_restaurant/entity/item.dart';
// import 'package:pbp_2_restaurant/view/pdf-and-printing/preview_screen.dart';
// import 'package:pbp_2_restaurant/view/pdf-and-printing/item_doc.dart';

// Future<void> createPdf(
//   TextEditingController nameController,
//   TextEditingController phoneController,
//   TextEditingController addressController,
//   String id,
//   BuildContext context,
//   List<Item> soldProducts,
// ) async {
//   final doc = pw.Document();
//   final now = DateTime.now();
//   final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

//   final pdfTheme = pw.PageTheme(
//     pageFormat: PdfPageFormat.a4,
//     buildBackground: (pw.Context context) {
//       return pw.Container(
//         decoration: pw.BoxDecoration(
//           border: null, // Set border to null to remove it
//         ),
//       );
//     },
//   );

//   final List<CustomRow> elements = [
//     // CustomRow("Keterangan", "Harga", "JML", "Total"),
//     for (var product in soldProducts)
//       CustomRow(
//         product.name!,
//         product.price!.toStringAsFixed(2),
//         product.amount.toString(),
//         (product.price * product.amount).toStringAsFixed(2),
//       ),
//   ];

//   pw.Widget itemColumn(List<CustomRow> elements) {
//     final headers = ['Keterangan', 'Harga', 'JML', 'Total'];
//     final data = elements.map((row) {
//       return [
//         row.itemName,
//         row.itemPrice,
//         row.amount,
//         row.subTotalProduct,
//       ];
//     }).toList();

//     // Creating a Table for the main content
//     final mainContentTable = pw.Table.fromTextArray(
//       headers: headers,
//       data: data,
//       cellAlignments: {
//         0: pw.Alignment.centerLeft,
//         1: pw.Alignment.centerRight,
//         2: pw.Alignment.centerRight,
//         3: pw.Alignment.centerRight,
//       },
//       headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//       headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       border: null,
//     );

//     pw.Widget buildText({
//       required String title,
//       String value = '',
//       pw.TextStyle? titleStyle,
//       bool unite = false,
//     }) {
//       return pw.Row(
//         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//         children: [
//           pw.Text(
//             title,
//             style: titleStyle ?? pw.TextStyle(),
//           ),
//           pw.Text(
//             value,
//             style: unite
//                 ? pw.TextStyle(fontWeight: pw.FontWeight.bold)
//                 : pw.TextStyle(),
//           ),
//         ],
//       );
//     }

//     // Creating lines for Sub-Total, PPN, and Total
//     final lines = pw.Container(
//       alignment: pw.Alignment.centerRight,
//       child: pw.Row(
//         children: [
//           pw.Spacer(flex: 6),
//           pw.Expanded(
//             flex: 4,
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Divider(),
//                 buildText(
//                   title: 'Sub Total',
//                   value: 'Rp ${getSubTotal(soldProducts)}',
//                   unite: true,
//                 ),
//                 buildText(
//                   title: 'PPN 11%',
//                   value: 'Rp ${getPPNTotal(soldProducts)}',
//                   unite: true,
//                 ),
//                 pw.Divider(),
//                 buildText(
//                   title: 'Total',
//                   titleStyle: pw.TextStyle(
//                     fontSize: 14,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                   value:
//                       'Rp ${(double.parse(getSubTotal(soldProducts)) + double.parse(getPPNTotal(soldProducts))).toStringAsFixed(2)}',
//                   unite: true,
//                 ),
//                 pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                 pw.Container(height: 1, color: PdfColors.grey400),
//                 pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
//                 pw.Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

//     // Combining the main content table and lines
//     return pw.Column(children: [mainContentTable, lines]);
//   }

//   pw.Widget table;
//   table = itemColumn(elements);

//   doc.addPage(
//     pw.MultiPage(
//       pageTheme: pdfTheme,
//       header: (pw.Context context) {
//         return headerPdf(
//           nameController.text,
//           "user@example.com", // Replace with the actual user's email
//           formattedDate,
//         );
//       },
//       build: (pw.Context context) {
//         return [
//           pw.Center(
//             child: pw.Column(
//               mainAxisAlignment: pw.MainAxisAlignment.center,
//               crossAxisAlignment: pw.CrossAxisAlignment.center,
//               children: [
//                 pw.Container(
//                   margin: pw.EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//                 ),
//                 // Removed the personalDataFromInput widget
//                 pw.SizedBox(height: 10),
//                 contentOfInvoice(table),
//               ],
//             ),
//           ),
//         ];
//       },
//       footer: (pw.Context context) {
//         return pw.Container(
//           color: PdfColor.fromHex('#FFBD59'),
//           child: footerPDF(formattedDate),
//         );
//       },
//     ),
//   );

//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PreviewScreen(doc: doc),
//     ),
//   );
// }

// pw.Widget headerPdf(String name, String email, String formattedDate) {
//   return pw.Header(
//     margin: pw.EdgeInsets.zero,
//     outlineColor: PdfColors.amber50,
//     outlineStyle: PdfOutlineStyle.normal,
//     level: 5,
//     child: pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text(
//               "Kepada",
//               style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15),
//             ),
//             pw.Text(
//               name,
//               style: pw.TextStyle(
//                 fontSize: 12,
//               ),
//             ),
//             pw.Text(
//               email,
//               style: pw.TextStyle(
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.end,
//           children: [
//             pw.Text(
//               "Tanggal",
//               style: pw.TextStyle(
//                 fontWeight: pw.FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             pw.Text(
//               formattedDate,
//               style: pw.TextStyle(
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// // Removed personalDataFromInput function

// pw.Padding contentOfInvoice(pw.Widget table) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.all(8.0),
//     child: pw.Column(children: [
//       pw.Text("Dear Customer, thank you for your purchase!"),
//       pw.SizedBox(height: 3),
//       table,
//       pw.Text("Thanks for your trust, and till the next time!"),
//       pw.SizedBox(height: 3),
//       pw.Text("Kind regards,"),
//       pw.SizedBox(height: 3),
//       pw.Text("Resto Online"),
//     ]),
//   );
// }

// pw.Center footerPDF(String formattedDate) => pw.Center(
//       child: pw.Text('Create At $formattedDate',
//           style: pw.TextStyle(fontSize: 10, color: PdfColors.blue)),
//     );
