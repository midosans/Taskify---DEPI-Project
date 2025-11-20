class UpdateBookingState {}

final class UpdateBookingInitial extends UpdateBookingState {}

final class UpdateBookingLoading extends UpdateBookingState {}

final class UpdateBookingSuccess extends UpdateBookingState {}

final class UpdateBookingFailure extends UpdateBookingState {
  final String errorMessage;

  UpdateBookingFailure({required this.errorMessage});
}
