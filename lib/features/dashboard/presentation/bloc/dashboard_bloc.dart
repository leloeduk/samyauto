import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../factures/data/facture_repo.dart';
import '../../../services/data/service_repo.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ServiceRepository serviceRepo;
  final FactureRepository factureRepo;

  DashboardBloc({required this.serviceRepo, required this.factureRepo})
    : super(DashboardInitial()) {
    on<LoadDashboard>((event, emit) async {
      emit(DashboardInitial()); // optionnel
      try {
        // Simuler un délai ou récupérer depuis DB/API
        await Future.delayed(const Duration(milliseconds: 300));

        final services = await serviceRepo.getAllAsync();
        final factures = await factureRepo.getAllAsync();

        final totalCA = factures.fold<double>(
          0,
          (previousValue, f) => previousValue + f.montantTotal,
        );

        emit(
          DashboardLoaded(
            totalServices: services.length,
            totalFactures: factures.length,
            chiffreAffaires: totalCA,
          ),
        );
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
  }
}
