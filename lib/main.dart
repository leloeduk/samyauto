import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samyauto/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:samyauto/features/factures/presentation/bloc/facture_bloc.dart';
import 'core/hive/hive_setup.dart';
import 'features/factures/data/facture_repo.dart';
import 'features/services/data/service_repo.dart';
import 'features/services/presentation/bloc/service_bloc.dart';
import 'features/services/presentation/bloc/service_event.dart';
import 'features/services/presentation/pages/service_form_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetup.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ServiceBloc(ServiceRepository())..add(LoadServices()),
          child: ServiceFormPage(),
        ),
        BlocProvider(create: (context) => FactureBloc(FactureRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Samy auto Offline',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        home: const DashboardPage(),
      ),
    );
  }
}
