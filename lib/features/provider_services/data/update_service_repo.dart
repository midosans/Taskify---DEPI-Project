import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateServiceRepo {
  Future<void> updateService(
    int serviceId,
    String? name,
    String? photoUrl,
    String? description,
    double? price,
    bool? availability,
  ) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final updates = {
      if (name != null) 'name': name,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (availability != null) 'availability': availability,
    };

    await supabase
        .from('bookings')
        .update({'status': updates})
        .eq('id', serviceId);
  }
}
