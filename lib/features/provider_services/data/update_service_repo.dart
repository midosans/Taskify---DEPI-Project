import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';

class UpdateServiceRepo {
  Future<void> updateService(
    String serviceId,
    String? title,
    String? description,
    double? price,
    File? photo,
    // bool? availability,
  ) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    String? photoUrl;
    if (user == null) throw Exception('Not authenticated');
    if (photo != null && photo.path.isNotEmpty) {
      final fileName =
          "${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg";

      await supabase.storage.from(serviceBucket).upload(fileName, photo);

      photoUrl = supabase.storage.from(serviceBucket).getPublicUrl(fileName);
    }
    final updates = {
      if (title != null) 'title': title,
      if (price != null) 'price': price,
      if (description != null) 'description': description,
      if (photoUrl != null) 'photo': photoUrl,

      // if (availability != null) 'availability': availability,
    };

    await supabase
        .from(servicesTable)
        .update(updates)
        // .update({'status': updates})
        .eq('id', serviceId);
  }
}
