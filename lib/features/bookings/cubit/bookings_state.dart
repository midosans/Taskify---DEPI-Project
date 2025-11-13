import 'package:taskify/features/bookings/data/booking_model.dart';

abstract class BookingState {}

class BookingsInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final List<BookingModel> bookings;
  BookingSuccess(this.bookings);
}

class BookingEmpty extends BookingState {}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}
