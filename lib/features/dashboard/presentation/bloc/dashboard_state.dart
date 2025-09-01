import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int totalServices;
  final int totalFactures;
  final double chiffreAffaires;

  DashboardLoaded({
    required this.totalServices,
    required this.totalFactures,
    required this.chiffreAffaires,
  });

  @override
  List<Object?> get props => [totalServices, totalFactures, chiffreAffaires];
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
