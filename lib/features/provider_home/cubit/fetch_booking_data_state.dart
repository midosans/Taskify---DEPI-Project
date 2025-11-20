class FetchBookingDataState {}

final class FetchBookingDataInitial extends FetchBookingDataState {}

final class FetchBookingDataLoading extends FetchBookingDataState {}

final class FetchBookingDataSuccess extends FetchBookingDataState {
  final List bookings;
  FetchBookingDataSuccess(this.bookings);
}

final class FetchBookingDataEmpty extends FetchBookingDataState {}

final class FetchBookingDataError extends FetchBookingDataState {
  final String message;
  FetchBookingDataError(this.message);
}

