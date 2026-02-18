import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static Future<List<int>> generate(
      PdfColor color, pw.Font fontFamily) async {
    final pdf = pw.Document();

    final iconImage =
        (await rootBundle.load('assets/icon.png')).buffer.asUint8List();

    final tableHeaders = [
      'Description',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total',
    ];

    final tableData = [
      ['Coffee', '7', '\$ 5', '1 %', '\$ 35'],
      ['Blue Berries', '5', '\$ 10', '2 %', '\$ 50'],
      ['Water', '1', '\$ 3', '1.5 %', '\$ 3'],
      ['Apple', '6', '\$ 8', '2 %', '\$ 48'],
      ['Lunch', '3', '\$ 90', '12 %', '\$ 270'],
      ['Drinks', '2', '\$ 15', '0.5 %', '\$ 30'],
      ['Lemon', '4', '\$ 7', '0.5 %', '\$ 28'],
    ];

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Row(
            children: [
              pw.Image(pw.MemoryImage(iconImage), height: 72, width: 72),
              pw.SizedBox(width: 10),
              pw.Text(
                'INVOICE',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: color,
                  font: fontFamily,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: tableHeaders,
            data: tableData,
          ),
        ],
      ),
    );

    final bytes = await pdf.save();
    return bytes;
  }
}

