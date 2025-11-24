import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/profile/cubit/update_profile_state.dart';
import 'package:taskify/features/profile/data/update_user_repo.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit({required this.updateProfileRepo}) : super(UpdateProfileInitial());
  final UpdateUserRepo updateProfileRepo;
  Future<void> saveProfileChanges({
    required String username,
    required String phone,
    String? newPassword,
    required String role,
    File? avatarFile,
  }) async {
    emit(UpdateProfileLoading());

    try {
      await updateProfileRepo.updateUser(username: username, phone: phone, role: role);
      if (newPassword != null && newPassword.isNotEmpty) {
        await updateProfileRepo.changePassword(newPassword);
      }
      if (avatarFile != null) {
        await updateProfileRepo.uploadavatar(avatarFile);
      }

      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }
}
