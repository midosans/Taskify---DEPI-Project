import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';

class UpdateBookingRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> updateBookingStatus({
    required String bookingId,
    required String newStatus,
  }) async {
    try {
      final response = await _supabase
          .from(bookingsTable)
          .update({'status': newStatus})
          .eq('id', bookingId)
          .select();

      if (response.isEmpty) {
  throw Exception("No rows updated. Invalid bookingId?");
}
    } catch (e) {
      debugPrint('Error updating booking status: $e');
      rethrow;
    }
  }
}
