import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';

class FetchBookingRepo {
   final SupabaseClient _supabase = Supabase.instance.client;
  Future<List<BookingModel>> getPendingBookings() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("Not logged in");

    try {
      final response = await _supabase
          .from('bookings')
          .select()
          .eq('provider_id', user.id)
          .eq('status', 'pending')
          .order('date', ascending: false);

      final data = response as List<dynamic>? ?? [];
      return data.map((e) => BookingModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Error fetching all bookings: $e');
      rethrow;
    }
  }

  
  Future<List<BookingModel>> getAcceptedBookings() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("Not logged in");

    try {
      final response = await _supabase
          .from('bookings')
          .select()
          .eq('provider_id', user.id)
          .eq('status', 'accepted')
          .order('date', ascending: false);

      final data = response as List<dynamic>? ?? [];
      return data.map((e) => BookingModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Error fetching bookings by status: $e');
      rethrow;
    }
  }
}