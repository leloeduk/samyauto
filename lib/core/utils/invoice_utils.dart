import 'dart:math';
import 'package:intl/intl.dart';

/// Génère un numéro de facture unique
/// Exemple : SAMY_Services20250901-ABC123
String generateNumeroFacture() {
  final datePart = DateFormat('yyyyMMdd').format(DateTime.now());
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();

  final uniquePart = List.generate(
    6,
    (_) => chars[random.nextInt(chars.length)],
  ).join();

  return "SAMY_Services$datePart-$uniquePart";
}

/// Formate un montant en FCFA avec séparateurs de milliers
/// Exemple : 12 500 FCFA
String formatMontant(double montant) {
  final formatter = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: 'FCFA',
    decimalDigits: 0,
  );
  return formatter.format(montant);
}

/// Formate une date au format lisible en français
/// Exemple : 1 septembre 2025, 14:35
String formatDate(DateTime date) {
  return DateFormat('d MMMM y, HH:mm', 'fr_FR').format(date);
}
