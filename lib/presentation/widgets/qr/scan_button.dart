import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_app/config/helpers/utils.dart';

import 'package:qr_app/presentation/providers/providers.dart';


class ScanButton extends StatelessWidget {
  
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final scanListProvider = context.watch<ScanListProvider>();

    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                                    '#${colors.primary.value.toRadixString(16)}', 
                                                    'Cancel', 
                                                    false, 
                                                    ScanMode.QR);

        if(barcodeScanRes == '-1') return;

        // geo:-36.878287,-73.148048
        final scan = await scanListProvider.addScan(barcodeScanRes);
        if (context.mounted) {
          launchURL(context, scan);
        }
      },
      child: Icon(Icons.filter_center_focus_outlined, color: colors.primary),
    );
  }
}