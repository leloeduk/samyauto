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
              if (factures.isEmpty) {
                return const Center(child: Text('Aucune facture disponible.'));
              }
              return ListView.builder(
                itemCount: factures.length,
                itemBuilder: (context, index) {
                  final facture = factures[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    child: ListTile(
                      title: Text(
                        facture.numeroFacture,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Client: ${facture.nomClient}"),
                                  Text("Montant: ${facture.montantTotal} FCFA"),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green.shade800,
                                  size: 30,
                                ),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        FactureFormPage(facture: facture),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade800,
                                  size: 30,
                                ),
                                onPressed: () => context
                                    .read<FactureBloc>()
                                    .add(DeleteFacture(facture)),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    FacturePdfPreviewPage(facture: facture),
                              ),
                            ),
                            child: const Text('Aperçu PDF'),
                          ),
                        ],
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     Icons.picture_as_pdf,
                      //     color: Colors.red.shade700,
                      //     size: 60,
                      //   ),
                      //   onPressed: () => Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) =>
                      //           FacturePdfPreviewPage(facture: facture),
                      //     ),
                      //   ),
                      // ),
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
