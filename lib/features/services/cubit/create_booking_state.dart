
abstract class CreateBookingState {}

class CreateBookingInitial extends CreateBookingState {}

class CreateBookingLoading extends CreateBookingState {}

class CreateBookingSuccess extends CreateBookingState {}

class CreateBookingError extends CreateBookingState {
  final String message;

  CreateBookingError(this.message);
}
