 class AddServiceState {}

 class AddServiceInitial extends AddServiceState {}
 class AddServiceLoading extends AddServiceState {}
 class AddServiceSuccess extends AddServiceState {}
 class AddServiceFailure extends AddServiceState {
    final String errorMessage;

  AddServiceFailure({required this.errorMessage});
 }
