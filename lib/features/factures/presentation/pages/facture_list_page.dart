import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/facture_repo.dart';
import '../bloc/facture_bloc.dart';
import '../bloc/facture_event.dart';
import '../bloc/facture_state.dart';
import 'facture_form_page.dart';
import 'facture_pdf_preview_page.dart';

class FactureListPage extends StatelessWidget {
  const FactureListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FactureBloc(FactureRepository())..add(LoadFactures()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Factures')),
        body: BlocBuilder<FactureBloc, FactureState>(
          builder: (context, state) {
            if (state is FactureInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FactureLoaded) {
              final factures = state.factures;
              if (factures.isEmpty)
                return const Center(child: Text('Aucune facture disponible.'));
              return ListView.builder(
                itemCount: factures.length,
                itemBuilder: (context, index) {
                  final facture = factures[index];
                  return ListTile(
                    title: Text(facture.numeroFacture),
                    subtitle: Text(
                      "Client: ${facture.nomClient} - Montant: ${facture.montantTotal} FCFA",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.picture_as_pdf),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FacturePdfPreviewPage(facture: facture),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FactureFormPage(facture: facture),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => context.read<FactureBloc>().add(
                            DeleteFacture(facture),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is FactureError) {
              return Center(child: Text('Erreur: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FactureFormPage()),
          ),
        ),
      ),
    );
  }
}
