import 'package:flutter/material.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';


class QRCodeScanner extends StatelessWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: AiBarcodeScanner(
        onDetect: (scannedData) {
          Navigator.pop(context, scannedData);
        },
      ),
    );
  }
}