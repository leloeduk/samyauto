import 'package:equatable/equatable.dart';
import '../../models/service_model.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadServices extends ServiceEvent {}

class AddService extends ServiceEvent {
  final ServiceModel service;
  AddService(this.service);

  @override
  List<Object?> get props => [service];
}

class UpdateService extends ServiceEvent {
  final ServiceModel service;
  UpdateService(this.service);

  @override
  List<Object?> get props => [service];
}

class DeleteService extends ServiceEvent {
  final ServiceModel service;
  DeleteService(this.service);

  @override
  List<Object?> get props => [service];
}
