import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/provider_home/cubit/update_booking_state.dart';
import 'package:taskify/features/provider_home/data/update_booking_repo.dart';

class UpdateBookingCubit extends Cubit<UpdateBookingState> {
  final UpdateBookingRepo repo;

  UpdateBookingCubit({required this.repo}) : super(UpdateBookingInitial());

  void updateBoookingStatus({
    required String bookingId,
    required String status,
  }) async {
    emit(UpdateBookingLoading());
    try {
      await repo.updateBookingStatus(bookingId: bookingId, newStatus: status);
      emit(UpdateBookingSuccess());
    } catch (e) {
      emit(UpdateBookingFailure(errorMessage: e.toString()));
    }
  }
}
