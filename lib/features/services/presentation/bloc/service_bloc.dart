import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/service_repo.dart';
import 'service_event.dart';
import 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository repo;

  ServiceBloc(this.repo) : super(ServiceInitial()) {
    on<LoadServices>((event, emit) {
      try {
        final services = repo.getAll();
        emit(ServiceLoaded(services));
      } catch (e) {
        emit(ServiceError(e.toString()));
      }
    });

    on<AddService>((event, emit) async {
      await repo.add(event.service);
      add(LoadServices());
    });

    on<UpdateService>((event, emit) async {
      await repo.update(event.service);
      add(LoadServices());
    });

    on<DeleteService>((event, emit) async {
      await repo.delete(event.service);
      add(LoadServices());
    });
  }
}
