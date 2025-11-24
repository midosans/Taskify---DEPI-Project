import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';

class UpdateUserRepo {
  final userId = Supabase.instance.client.auth.currentUser!.id;
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> changePassword(String newPassword) async {
    await _supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<void> updateUser({
    required String username,
    required String phone,
    required String role,
  }) async {
    final response =
        await _supabase
            .from('profile')
            .update({'username': username, 'phone': phone})
            .eq('id', userId)
            .select()
            .maybeSingle();
    if (response == null) {
      throw Exception('User update failed');
    }

    if(role == 'User'){
      await _supabase
          .from(bookingsTable)
          .update({'username': username})
          .eq('user_id', userId);
    }else{
      await _supabase
          .from(bookingsTable)
          .update({'provider_name': username})
          .eq('provider_id', userId);
      await _supabase
          .from(servicesTable)
          .update({'provider_name': username})
          .eq('provider_id', userId);
    }
  }

  Future<void> uploadavatar(File photo) async {
    String? photoUrl;
    if (photo.path.isNotEmpty) {
      final fileName = "${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      await _supabase.storage.from(avatarBucket).upload(fileName, photo);
      photoUrl = _supabase.storage.from(avatarBucket).getPublicUrl(fileName);
    }
    await _supabase
        .from(profileTable)
        .update({'avatar': photoUrl})
        .eq('id', userId);
  }
}
