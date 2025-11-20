import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';

class AddServiceRepo {
  Future<void> addService({
    required String title,
    required String description,
    required double price,
    required File photo,
  }) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) throw Exception("Not logged in");

    final profileResponse =
        await supabase
            .from(profileTable)
            .select('username, role')
            .eq('id', user.id)
            .maybeSingle();

    if (profileResponse == null) {
      throw Exception("User profile not found");
    }

    final providerName = profileResponse['username'] ?? '';
    final providerRole = profileResponse['role'] ?? '';

    String? photoUrl;
    if (photo.path.isNotEmpty) {
      final fileName =
          "${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      await supabase.storage.from(serviceBucket).upload(fileName, photo);
      photoUrl = supabase.storage.from(serviceBucket).getPublicUrl(fileName);
    }

    await supabase.from('services').insert({
      'provider_id': user.id,
      'provider_name': providerName,
      'category': providerRole,
      'title': title,
      'description': description,
      'price': price,
      'photo': photoUrl,
      'availability': true,
    });
  }
}
