import 'package:hive/hive.dart';
import '../../services/models/service_model.dart';
part 'facture_model.g.dart';

@HiveType(typeId: 1)
enum StatutFacture {
  @HiveField(0)
  paye,

  @HiveField(1)
  nonPaye,

  @HiveField(2)
  enCours,
}

@HiveType(typeId: 2)
enum ModePaiement {
  @HiveField(0)
  espece,

  @HiveField(1)
  mobile,

  @HiveField(2)
  carte,
}

@HiveType(typeId: 3)
class FactureModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String numeroFacture;

  @HiveField(2)
  String nomClient;

  @HiveField(3)
  String auteurId;

  @HiveField(4)
  ServiceModel? service;

  @HiveField(5)
  String laveurId;

  @HiveField(6)
  double montant;

  @HiveField(7)
  double montantTotal;

  @HiveField(8)
  double commissionLaveur;

  @HiveField(9)
  double partEntreprise;

  @HiveField(10)
  StatutFacture statut;

  @HiveField(11)
  ModePaiement modePaiement;

  @HiveField(12)
  DateTime dateHeure;

  @HiveField(13)
  String? commentaire;

  FactureModel({
    required this.id,
    required this.numeroFacture,
    required this.nomClient,
    required this.auteurId,
    this.service,
    required this.laveurId,
    required this.montant,
    required this.montantTotal,
    required this.commissionLaveur,
    required this.partEntreprise,
    required this.statut,
    required this.modePaiement,
    required this.dateHeure,
    this.commentaire,
  });
}
