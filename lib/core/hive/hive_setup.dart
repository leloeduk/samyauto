import 'package:hive_flutter/hive_flutter.dart';

import '../../features/factures/models/facture_model.dart';
import '../../features/services/models/service_model.dart';

class HiveSetup {
  static const servicesBox = 'services';
  static const facturesBox = 'factures';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ServiceModelAdapter());
    Hive.registerAdapter(FactureModelAdapter());
    Hive.registerAdapter(StatutFactureAdapter());
    Hive.registerAdapter(ModePaiementAdapter());

    await Hive.openBox<ServiceModel>(servicesBox);
    await Hive.openBox<FactureModel>(facturesBox);
  }
}
