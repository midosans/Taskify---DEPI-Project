import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/features/bookings/cubit/delete_booking_state.dart';
import 'package:taskify/features/bookings/data/delete_booking_repo.dart';

class DeleteBookingCubit extends Cubit<DeleteBookingState> {
  DeleteBookingCubit({required this.deleteBookingRepo}) : super(DeleteBookingInitial());
  final DeleteBookingRepo deleteBookingRepo;
  void deleteBooking({required String id,}) async {
    emit(DeleteBookingLoading());
    bool connected = await hasInternet();
    if(connected == true){
    try {
      deleteBookingRepo.deleteBooking(id);
      emit(DeleteBookingSuccess());
    } catch (e) {
      emit(DeleteBookingFailure(errorMessage: e.toString()));
    }
  }else{
    emit(DeleteBookingFailure(errorMessage: 'no_internet_connection'.tr()));
  }
  }
}
