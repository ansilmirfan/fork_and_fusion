import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

class QRCodeScanner extends StatelessWidget {
  const QRCodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AiBarcodeScanner(
        onDetect: (scannedData) {
          final List<Barcode> barcodes = scannedData.barcodes;

          String barcodeData = '';
          for (var barcode in barcodes) {
             barcodeData = barcode.rawValue ?? 'Unknown';
          }
          log(barcodeData);
          Navigator.pop(context, barcodeData);
        },
      ),
    );
  }
}
