import 'package:flutter/material.dart';
import 'package:samyauto/features/dashboard/presentation/pages/dashboard_page.dart';
import 'core/hive/hive_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetup.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Samy auto Offline',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const DashboardPage(),
    );
  }
}
