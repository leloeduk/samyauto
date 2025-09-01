import 'package:hive/hive.dart';
import '../../../core/hive/hive_setup.dart';
import '../models/service_model.dart';

class ServiceRepository {
  final Box<ServiceModel> _box = Hive.box<ServiceModel>(HiveSetup.servicesBox);

  /// Retourne toutes les services
  List<ServiceModel> getAll() {
    return _box.values.toList();
  }

  /// Ajouter un service
  Future<void> add(ServiceModel service) async {
    await _box.put(service.id, service);
  }

  /// Mettre à jour un service
  Future<void> update(ServiceModel service) async {
    await _box.put(service.id, service);
  }

  /// Supprimer un service
  Future<void> delete(ServiceModel service) async {
    await _box.delete(service.id);
  }

  /// Trouver un service par ID
  ServiceModel? getById(String id) {
    return _box.get(id);
  }

  Future<List<ServiceModel>> getAllAsync() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.toList();
  }
}
