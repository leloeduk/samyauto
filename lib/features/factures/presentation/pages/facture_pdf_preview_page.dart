import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:samyauto/features/factures/models/facture_model.dart';
import '../../utils/facture_pdf.dart';

class FacturePdfPreviewPage extends StatelessWidget {
  final FactureModel facture;
  const FacturePdfPreviewPage({super.key, required this.facture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prévisualiser Facture')),
      body: PdfPreview(
        build: (format) async {
          final pdfBytes = await generateFacturePdf(facture);
          return Uint8List.fromList(pdfBytes);
        },
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: false,
        canChangeOrientation: false,
      ),
    );
  }
}
