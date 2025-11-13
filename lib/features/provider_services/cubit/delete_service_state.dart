class DeleteServiceState {}

class DeleteServiceInitial extends DeleteServiceState {}

class DeleteServiceLoading extends DeleteServiceState {}

class DeleteServiceSuccess extends DeleteServiceState {}

class DeleteServiceFailure extends DeleteServiceState {
  final String errorMessage;

  DeleteServiceFailure({required this.errorMessage});
}
