class UpdateServiceState {}

class UpdateServiceInitial extends UpdateServiceState {}

class UpdateServiceLoading extends UpdateServiceState {}

class UpdateServiceSuccess extends UpdateServiceState {}

class UpdateServiceFailure extends UpdateServiceState {
  final String errorMessage;

  UpdateServiceFailure({required this.errorMessage});
}
