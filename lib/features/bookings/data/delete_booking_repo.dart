import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';

class DeleteBookingRepo {
  final supabase = Supabase.instance.client;

  Future<void> deleteBooking(String bookingId) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');
    await supabase.from(bookingsTable).delete().eq('id', bookingId);
  }
}
