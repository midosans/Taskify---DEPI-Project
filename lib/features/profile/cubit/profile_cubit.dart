import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/features/profile/cubit/profile_state.dart';
import 'package:taskify/features/profile/data/user_data_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  UserDataRepo userDataRepo = UserDataRepo();

  Future<void> fetchUserData() async {
    emit(ProfileLoading());
    bool connected = await hasInternet();
    if (!connected) {
      emit(ProfileError('no_internet_connection'.tr()));
      return;
    }
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;

      final data = await userDataRepo.getUserData(userId!);
      emit(ProfileLoaded(userdataModel: data));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
