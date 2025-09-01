import 'package:pdf/widgets.dart' as pw;
import 'package:samyauto/features/factures/models/facture_model.dart';

Future<List<int>> generateFacturePdf(FactureModel facture) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "FACTURE ${facture.numeroFacture}",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Text("Client : ${facture.nomClient}"),
            pw.Text("Service : ${facture.service?.nom ?? '-'}"),
            pw.Text("Montant : ${facture.montant} FCFA"),
            pw.Text("Commission laveur : ${facture.commissionLaveur} FCFA"),
            pw.Text("Part entreprise : ${facture.partEntreprise} FCFA"),
            pw.SizedBox(height: 20),
            pw.Text("Statut : ${facture.statut.name}"),
            pw.Text("Paiement : ${facture.modePaiement.name}"),
            pw.Text("Date : ${facture.dateHeure}"),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
