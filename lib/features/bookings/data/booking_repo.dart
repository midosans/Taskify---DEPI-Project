import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';

class BookingRepo {
  final SupabaseClient _supabase = Supabase.instance.client;


  Future<List<BookingModel>> getAllBookings() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("Not logged in");

    try {
      final response = await _supabase
          .from('bookings')
          .select()
          .eq('user_id', user.id)
          .order('date', ascending: false);

      final data = response as List<dynamic>? ?? [];
      return data.map((e) => BookingModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Error fetching all bookings: $e');
      rethrow;
    }
  }

  
  Future<List<BookingModel>> getBookingsByStatus({
    required String status,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("Not logged in");

    try {
      final response = await _supabase
          .from('bookings')
          .select()
          .eq('user_id', user.id)
          .eq('status', status)
          .order('date', ascending: false);

      final data = response as List<dynamic>? ?? [];
      return data.map((e) => BookingModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Error fetching bookings by status: $e');
      rethrow;
    }
  }


  Future<void> updateBookingStatus({
    required String bookingId,
    required String newStatus,
  }) async {
    try {
      final response = await _supabase
          .from('bookings')
          .update({'status': newStatus})
          .eq('id', bookingId);

      if (response == null) {
        throw Exception("Failed to update booking");
      }
    } catch (e) {
      debugPrint('Error updating booking status: $e');
      rethrow;
    }
  }
}
