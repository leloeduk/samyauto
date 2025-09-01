import 'package:hive/hive.dart';
part 'service_model.g.dart';

@HiveType(typeId: 0)
class ServiceModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nom;

  @HiveField(2)
  double prixTotal;

  @HiveField(3)
  double commissionLaveur;

  @HiveField(4)
  String? description;

  @HiveField(5)
  DateTime dateCreation;

  ServiceModel({
    required this.id,
    required this.nom,
    required this.prixTotal,
    required this.commissionLaveur,
    this.description,
    required this.dateCreation,
  });

  double get partEntreprise => prixTotal - commissionLaveur;
}
