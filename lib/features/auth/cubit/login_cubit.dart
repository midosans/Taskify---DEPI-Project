import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/auth/cubit/login_state.dart';
import 'package:taskify/features/auth/data/login_repo.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit({required this.loginRepo }) : super(LoginInitial());
  final LoginRepo loginRepo;

  void Login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final profileData = await loginRepo.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess(profileData));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}