import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';
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

  Future<BookingModel> createBooking({
    required String serviceId,
    required String providerId,
    required String providerName,
    required String serviceTitle,
    required DateTime date,
    required DateTime time,
    required String address,
    required File photo
  }) async {

    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("Not logged in");
    
    final profileResponse = await _supabase
        .from(profileTable)
        .select('username')
        .eq('id', user.id)
        .maybeSingle();

    if (profileResponse == null) {
      throw Exception("User profile not found");
    }

    final userName = profileResponse['username'] ?? '';
    

    try {
      // هرفع الصورة لو موجودة
       String? photoUrl;
    if (photo.path.isNotEmpty) {
      final fileName = "${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      await _supabase.storage.from(serviceBucket).upload(fileName, photo);
      photoUrl = _supabase.storage.from(serviceBucket).getPublicUrl(fileName);
    }
    
      // insert row
      final inserted =
          await _supabase
              .from('bookings')
              .insert({
                'user_id': user.id,
                'user_name': userName,
                'provider_name': providerName,
                'service_id': serviceId,
                'service_title': serviceTitle,
                'provider_id': providerId,
                'date': date.toIso8601String(),
                'time': time.toIso8601String(), 
                'address': address,
                'image_url': photoUrl,
                'status': 'upcoming',
              })
              .select()
              .single();

      return BookingModel.fromMap(inserted);
    } catch (e) {
      debugPrint('Error creating booking: $e');
      rethrow;
    }
  }
}
