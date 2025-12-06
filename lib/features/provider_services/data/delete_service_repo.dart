import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';

class DeleteServiceRepo {
  final supabase = Supabase.instance.client;

  Future<void> deleteService(String serviceId) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // Attempt to delete the booking
    await supabase.from(servicesTable).delete().eq('id', serviceId);

    // if (response.error != null) {
    //   throw Exception(response.error!.message);
    // } else {
    //   debugPrint('Booking deleted successfully');
    // }
  }
}
