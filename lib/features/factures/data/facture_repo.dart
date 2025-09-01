import 'package:hive/hive.dart';
import 'package:samyauto/features/factures/models/facture_model.dart';
import '../../../core/hive/hive_setup.dart';

class FactureRepository {
  final Box<FactureModel> _box = Hive.box<FactureModel>(HiveSetup.facturesBox);

  /// Retourne toutes les factures
  List<FactureModel> getAll() {
    return _box.values.toList();
  }

  /// Ajouter une facture
  Future<void> add(FactureModel facture) async {
    await _box.put(facture.id, facture);
  }

  /// Mettre à jour une facture
  Future<void> update(FactureModel facture) async {
    await _box.put(facture.id, facture);
  }

  /// Supprimer une facture
  Future<void> delete(FactureModel facture) async {
    await _box.delete(facture.id);
  }

  /// Trouver une facture par ID
  FactureModel? getById(String id) {
    return _box.get(id);
  }

  Future<List<FactureModel>> getAllAsync() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.toList();
  }
}
