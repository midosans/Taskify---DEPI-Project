import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/features/provider_home/data/fetch_booking_repo.dart';
import 'package:taskify/features/provider_home/cubit/fetch_booking_data_state.dart';

class FetchPendingBookingsCubit extends Cubit<FetchBookingDataState> {
  final FetchBookingRepo repo;

  FetchPendingBookingsCubit({required this.repo})
    : super(FetchBookingDataInitial());

  Future<void> loadPending() async {
    emit(FetchBookingDataLoading());
    bool connected = await hasInternet();
    if (connected) {
      try {
        final bookings = await repo.getPendingBookings();
        bookings.isEmpty
            ? emit(FetchBookingDataEmpty())
            : emit(FetchBookingDataSuccess(bookings));
      } catch (e) {
        emit(FetchBookingDataError(e.toString()));
      }
    } else {
      emit(FetchBookingDataError('no_internet_connection'.tr()));
    }
  }
}
