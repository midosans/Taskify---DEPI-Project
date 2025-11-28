import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/features/auth/cubit/signup_state.dart';
import 'package:taskify/features/auth/data/signup_repo.dart';

class SignupCubit extends Cubit<SignupState>{
  SignupCubit({required this.signupRepo }) : super(SignupInitial());
  final SignupRepo signupRepo;

  void SignUp({
    required String email,
    required String password,
    required String role, 
    String? username,
    String? phone,
  }) async {
    emit(SignupLoading());
            bool connected = await hasInternet();
        if (!connected) {
          emit(SignupFailure('no_internet_connection'.tr()));
          return;
        }
    try {
      await signupRepo.signUp(
        email: email,
        password: password,
        role: role,
        username: username,
        phone: phone,
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}