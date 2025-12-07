class DeleteBookingState {}

class DeleteBookingInitial extends DeleteBookingState {}

class DeleteBookingLoading extends DeleteBookingState {}

class DeleteBookingSuccess extends DeleteBookingState {}

class DeleteBookingFailure extends DeleteBookingState {
  final String errorMessage;

  DeleteBookingFailure({required this.errorMessage});
}
