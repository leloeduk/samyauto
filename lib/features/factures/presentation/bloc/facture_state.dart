import 'package:equatable/equatable.dart';

import '../../models/facture_model.dart';

abstract class FactureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FactureInitial extends FactureState {}

class FactureLoaded extends FactureState {
  final List<FactureModel> factures;
  FactureLoaded(this.factures);

  @override
  List<Object?> get props => [factures];
}

class FactureError extends FactureState {
  final String message;
  FactureError(this.message);

  @override
  List<Object?> get props => [message];
}
