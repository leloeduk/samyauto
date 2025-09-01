import 'package:equatable/equatable.dart';

import '../../models/facture_model.dart';

abstract class FactureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFactures extends FactureEvent {}

class AddFacture extends FactureEvent {
  final FactureModel facture;
  AddFacture(this.facture);

  @override
  List<Object?> get props => [facture];
}

class UpdateFacture extends FactureEvent {
  final FactureModel facture;
  UpdateFacture(this.facture);

  @override
  List<Object?> get props => [facture];
}

class DeleteFacture extends FactureEvent {
  final FactureModel facture;
  DeleteFacture(this.facture);

  @override
  List<Object?> get props => [facture];
}
