import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samyauto/features/services/models/service_model.dart';
import '../bloc/service_bloc.dart';
import '../bloc/service_event.dart';

class ServiceFormPage extends StatefulWidget {
  final ServiceModel? service;
  const ServiceFormPage({super.key, this.service});

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _prixController;
  late TextEditingController _commissionController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.service?.nom ?? '');
    _prixController = TextEditingController(
      text: widget.service?.prixTotal.toString() ?? '',
    );
    _commissionController = TextEditingController(
      text: widget.service?.commissionLaveur.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.service?.description ?? '',
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prixController.dispose();
    _commissionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      final id =
          widget.service?.id ??
          DateTime.now().millisecondsSinceEpoch.toString();
      final service = ServiceModel(
        id: id,
        nom: _nomController.text,
        prixTotal: double.parse(_prixController.text),
        commissionLaveur: double.parse(_commissionController.text),
        description: _descriptionController.text,
        dateCreation: widget.service?.dateCreation ?? DateTime.now(),
      );

      final bloc = context.read<ServiceBloc>();
      if (widget.service == null) {
        bloc.add(AddService(service));
      } else {
        bloc.add(UpdateService(service));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.service == null ? 'Ajouter Service' : 'Modifier Service',
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
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom du service'),
                validator: (value) => value!.isEmpty ? 'Obligatoire' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _prixController,
                decoration: const InputDecoration(
                  labelText: 'Prix total (FCFA)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Obligatoire' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _commissionController,
                decoration: const InputDecoration(
                  labelText: 'Commission laveur (FCFA)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Obligatoire' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveService,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
