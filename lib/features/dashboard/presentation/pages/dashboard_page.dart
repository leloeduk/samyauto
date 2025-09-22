import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/invoice_utils.dart';
import '../../../factures/data/facture_repo.dart';
import '../../../factures/presentation/pages/facture_list_page.dart';
import '../../../services/data/service_repo.dart';
import '../../../services/presentation/pages/service_list_page.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void _navigateTo(BuildContext context, String type) {
    if (type == 'services') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ServiceListPage()),
      );
    } else if (type == 'factures') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FactureListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(
        serviceRepo: ServiceRepository(),
        factureRepo: FactureRepository(),
      )..add(LoadDashboard()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _StatCard(
                          title: "Services",
                          value: state.totalServices.toString(),
                          color: Colors.blue,
                          onTap: () => _navigateTo(context, 'services'),
                        ),
                        _StatCard(
                          title: "Factures",
                          value: state.totalFactures.toString(),
                          color: Colors.green,
                          onTap: () => _navigateTo(context, 'factures'),
                        ),
                        _StatCard(
                          title: "Chiffre d'affaires",
                          value: formatMontant(state.chiffreAffaires),
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Statistiques graphiques à implémenter ici',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DashboardError) {
              return Center(child: Text('Erreur: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: color.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
