import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/home/cubit/home_state.dart';
import 'package:taskify/features/home/data/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeInitial());
  HomeRepo homeRepo;

  // Future<void> getAllBookings() async {
  //   emit(HomeLoading());
  //   final bookings = await homeRepo.getBookinghome();
  //   bookings.fold(
  //     (message) => emit(HomeFailure(errorMessage: message)),
  //     (bookings) => emit(HomeSuccess(bookings: bookings)),
  //   );
  // }

  Future<void> getUpcomingBookings() async {
    emit(HomeLoading());
    final bookings = await homeRepo.getUpcomingBookings();
    bookings.fold(
      (message) => emit(HomeFailure(errorMessage: message)),
      (bookings) => emit(HomeSuccess(bookings: bookings)),
    );
  }
}
