import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/provider/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class CustomFabButton extends StatelessWidget {
  const CustomFabButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<ScanListProvider>(context, listen: false);

    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#25243c", "Cancelar", false, ScanMode.QR);

        if (barcodeScanRes == "-1") {
          return;
        }

        final newScan = await db.addScan(barcodeScanRes);

        launchUrl(newScan, context);
      },
      child: const Icon(Icons.center_focus_strong_rounded),
      elevation: 6,
    );
  }
}
