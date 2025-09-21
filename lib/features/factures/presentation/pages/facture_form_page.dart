import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samyauto/features/factures/models/facture_model.dart';
import 'package:samyauto/features/services/models/service_model.dart';
import '../../../../core/utils/invoice_utils.dart';
import '../../../services/data/service_repo.dart';
import '../bloc/facture_bloc.dart';
import '../bloc/facture_event.dart';

class FactureFormPage extends StatefulWidget {
  final FactureModel? facture;
  const FactureFormPage({super.key, this.facture});

  @override
  State<FactureFormPage> createState() => _FactureFormPageState();
}

class _FactureFormPageState extends State<FactureFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomClientController;
  late TextEditingController _montantController;
  ServiceModel? _selectedService;
  List<ServiceModel> _services = [];

  @override
  void initState() {
    super.initState();
    _nomClientController = TextEditingController(
      text: widget.facture?.nomClient ?? '',
    );
    _montantController = TextEditingController(
      text: widget.facture?.montant.toString() ?? '',
    );
    _services = ServiceRepository().getAll();
    if (widget.facture?.service != null) {
      _selectedService = widget.facture!.service;
    }
  }

  @override
  void dispose() {
    _nomClientController.dispose();
    _montantController.dispose();
    super.dispose();
  }

  void _saveFacture() {
    if (_formKey.currentState!.validate() && _selectedService != null) {
      final id =
          widget.facture?.id ??
          DateTime.now().millisecondsSinceEpoch.toString();
      final montant = double.parse(_montantController.text);

      final facture = FactureModel(
        id: id,
        numeroFacture: widget.facture?.numeroFacture ?? generateNumeroFacture(),
        nomClient: _nomClientController.text,
        auteurId: "admin",
        service: _selectedService,
        laveurId: "laveur_123",
        montant: montant,
        montantTotal: montant,
        commissionLaveur: _selectedService!.commissionLaveur,
        partEntreprise: montant - _selectedService!.commissionLaveur,
        statut: StatutFacture.enCours,
        modePaiement: ModePaiement.espece,
        dateHeure: widget.facture?.dateHeure ?? DateTime.now(),
        commentaire: '',
      );

      final bloc = context.read<FactureBloc>();
      if (widget.facture == null) {
        bloc.add(AddFacture(facture));
      } else {
        bloc.add(UpdateFacture(facture));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.facture == null ? 'Ajouter Facture' : 'Modifier Facture',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              TextFormField(
                controller: _nomClientController,
                decoration: const InputDecoration(labelText: 'Nom du client'),
                validator: (value) => value!.isEmpty ? 'Obligatoire' : null,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<ServiceModel>(
                initialValue: _selectedService,
                items: _services
                    .map((s) => DropdownMenuItem(value: s, child: Text(s.nom)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedService = val),
                decoration: const InputDecoration(labelText: 'Service'),
                validator: (value) =>
                    value == null ? 'Sélectionner un service' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _montantController,
                decoration: const InputDecoration(labelText: 'Montant (FCFA)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Obligatoire' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveFacture,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
