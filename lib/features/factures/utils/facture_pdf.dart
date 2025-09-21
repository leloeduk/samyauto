import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../models/facture_model.dart';

Future<List<int>> generateFacturePdf(FactureModel facture) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (context) {
        return pw.Center(
          child: pw.Container(
            width: double.infinity,
            height: double.infinity,
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // HEADER
                pw.Text(
                  "FACTURE SAMY AUTO",
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue900,
                  ),
                ),

                pw.SizedBox(height: 24),

                // NUMERO FACTURE
                pw.Text(
                  "N° ${facture.numeroFacture}",
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey800,
                  ),
                ),

                pw.SizedBox(height: 24),
                pw.Divider(height: 2, thickness: 2, color: PdfColors.grey600),
                pw.SizedBox(height: 24),
                pw.SizedBox(height: 24),

                // CLIENT & SERVICE
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Client : ${facture.nomClient}",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Text(
                      "Service : ${facture.service?.nom ?? '-'}",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Text(
                      "Montant : ${facture.montant} FCFA",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Text(
                      "Commission laveur : ${facture.commissionLaveur} FCFA",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Text(
                      "Part entreprise : ${facture.partEntreprise} FCFA",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                  ],
                ),

                pw.SizedBox(height: 30),
                pw.Divider(height: 1, thickness: 1, color: PdfColors.grey500),
                pw.SizedBox(height: 24),
                pw.SizedBox(height: 24),

                // STATUT & PAIEMENT & DATE
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          "Statut",
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          facture.statut.name,
                          style: pw.TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          "Mode Paiement",
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          facture.modePaiement.name,
                          style: pw.TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          "Date",
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          "${facture.dateHeure.day}/${facture.dateHeure.month}/${facture.dateHeure.year}",
                          style: pw.TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 50),

                // FOOTER
                pw.Center(
                  child: pw.Text(
                    "Merci pour votre confiance !",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontStyle: pw.FontStyle.italic,
                      color: PdfColors.grey700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  return pdf.save();
}
