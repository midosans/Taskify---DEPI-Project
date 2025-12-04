import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/features/services/cubit/create_booking_state.dart';
import 'package:taskify/features/bookings/data/booking_repo.dart';

class CreateBookingCubit extends Cubit<CreateBookingState> {
  final BookingRepo bookingRepo;

  CreateBookingCubit({required this.bookingRepo})
    : super(CreateBookingInitial());
  Future<void> createBooking({
    required String serviceId,
    required String providerId,
    required String providerName,
    required String serviceTitle,
    required DateTime date,
    required DateTime time,
    required String address,
    required File photo
  }) async {
    emit(CreateBookingLoading());
            bool connected = await hasInternet();
        if (!connected) {
          emit(CreateBookingError('no_internet_connection'.tr()));
          return;
        }
    try {
      await bookingRepo.createBooking(
        serviceId: serviceId,
        providerId: providerId,
        providerName: providerName,
        serviceTitle: serviceTitle,
        date: date,
        time: time,
        address: address,
        photo: photo,
      );
      emit(CreateBookingSuccess());
    } catch (e) {
      emit(CreateBookingError('Failed to create booking: $e'));
    }
  }
}
