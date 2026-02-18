import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdf_invoice_api.dart';
import 'file_handle_api.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Invoice PDF Generate',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PdfColor themeColor = PdfColors.black;
  pw.Font font = pw.Font.courier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<PdfColor>(
              decoration: const InputDecoration(
                hintText: 'Select Theme color',
              ),
              items: const [
                DropdownMenuItem(
                  value: PdfColors.black,
                  child: Text('Black'),
                ),
                DropdownMenuItem(
                  value: PdfColors.grey900,
                  child: Text('Dark Grey'),
                ),
                DropdownMenuItem(
                  value: PdfColors.green,
                  child: Text('Green'),
                ),
                DropdownMenuItem(
                  value: PdfColors.blue,
                  child: Text('Blue'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    themeColor = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<pw.Font Function()>(
              decoration: const InputDecoration(
                hintText: 'Select Font',
              ),
              items: const [
                DropdownMenuItem(
                  value: pw.Font.courier,
                  child: Text('Courier'),
                ),
                DropdownMenuItem(
                  value: pw.Font.helvetica,
                  child: Text('Helvetica'),
                ),
                DropdownMenuItem(
                  value: pw.Font.times,
                  child: Text('Times'),
                ),
                DropdownMenuItem(
                  value: pw.Font.zapfDingbats,
                  child: Text('ZapfDingbats'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    font = value();
                  });
                }
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                final pdfBytes =
                    await PdfInvoiceApi.generate(themeColor, font);

                await saveAndOpenFile(pdfBytes, "invoice.pdf");
              },
              child: const Text('Generate Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}

