import 'package:taskify/features/bookings/data/booking_model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  List<BookingModel> bookings;
  HomeSuccess({required this.bookings});
}

class HomeFailure extends HomeState {
  String errorMessage;
  HomeFailure({required this.errorMessage});
}
