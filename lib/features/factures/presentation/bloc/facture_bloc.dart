import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/facture_repo.dart';
import 'facture_event.dart';
import 'facture_state.dart';

class FactureBloc extends Bloc<FactureEvent, FactureState> {
  final FactureRepository repo;

  FactureBloc(this.repo) : super(FactureInitial()) {
    on<LoadFactures>((event, emit) {
      try {
        final factures = repo.getAll();
        emit(FactureLoaded(factures));
      } catch (e) {
        emit(FactureError(e.toString()));
      }
    });

    on<AddFacture>((event, emit) async {
      await repo.add(event.facture);
      add(LoadFactures());
    });

    on<UpdateFacture>((event, emit) async {
      await repo.update(event.facture);
      add(LoadFactures());
    });

    on<DeleteFacture>((event, emit) async {
      await repo.delete(event.facture);
      add(LoadFactures());
    });
  }
}
