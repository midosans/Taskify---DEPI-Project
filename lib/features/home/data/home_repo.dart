import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';

class HomeRepo {
  Future<Either<String, List<BookingModel>>> getBookinghome() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("Not logged in");
    try {
      final response = await supabase
          .from(bookingsTable)
          .select()
          .eq('user_id', user.id);
      final List<BookingModel> bookingHome =
          (response as List)
              .map((service) => BookingModel.fromMap(service))
              .toList();
      return Right(bookingHome);
    } on PostgrestException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<BookingModel>>> getUpcomingBookings() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("Not logged in");
    try {
      final response = await supabase
          .from(bookingsTable)
          .select()
          .eq('user_id', user.id)
          .eq('status', 'pending')
          .order('date', ascending: true);
      final List<BookingModel> upcomingBookings =
          (response as List)
              .map((service) => BookingModel.fromMap(service))
              .toList();
      return Right(upcomingBookings);
    } on PostgrestException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
