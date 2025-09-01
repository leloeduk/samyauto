import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/service_repo.dart';
import '../bloc/service_bloc.dart';
import '../bloc/service_event.dart';
import '../bloc/service_state.dart';
import 'service_form_page.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceBloc(ServiceRepository())..add(LoadServices()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Services')),
        body: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            if (state is ServiceInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceLoaded) {
              final services = state.services;
              if (services.isEmpty) {
                return const Center(child: Text('Aucun service disponible.'));
              }
              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return ListTile(
                    title: Text(service.nom),
                    subtitle: Text("Prix: ${service.prixTotal} FCFA"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ServiceFormPage(service: service),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<ServiceBloc>().add(
                              DeleteService(service),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is ServiceError) {
              return Center(child: Text('Erreur: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ServiceFormPage()),
          ),
        ),
      ),
    );
  }
}
