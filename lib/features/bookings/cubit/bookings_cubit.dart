import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/bookings/cubit/bookings_state.dart';
import 'package:taskify/features/bookings/data/booking_repo.dart';

class BookingsCubit extends Cubit<BookingState> {
  final BookingRepo bookingRepo;

  BookingsCubit({required this.bookingRepo}) : super(BookingsInitial());

  Future<void> getAllBookings() async {
    emit(BookingLoading());
    try {
      final bookings = await bookingRepo.getAllBookings();
      if (bookings.isEmpty) {
        emit(BookingEmpty());
      } else {
        emit(BookingSuccess(bookings));
      }
    } catch (e) {
      emit(BookingError('Failed to fetch bookings: $e'));
    }
  }

  Future<void> getBookingsByStatus({required String status}) async {
    emit(BookingLoading());
    try {
      final bookings = await bookingRepo.getBookingsByStatus(status: status);
      if (bookings.isEmpty) {
        emit(BookingEmpty());
      } else {
        emit(BookingSuccess(bookings));
      }
    } catch (e) {
      emit(BookingError('Failed to fetch bookings: $e'));
    }
  }

  

  Future<void> fetchForTab(int tabIndex) async {
    switch (tabIndex) {
      case 0:
        await getAllBookings();
        break;
      case 1:
        await getBookingsByStatus(status: 'completed');
        break;
      case 2:
        await getBookingsByStatus(status: 'accepted');
        break;
      case 3:
        await getBookingsByStatus(status: 'pending');
        break;
      case 4:
        await getBookingsByStatus(status: 'cancelled');
        break;
      default:
        await getAllBookings();
    }
  }
}
