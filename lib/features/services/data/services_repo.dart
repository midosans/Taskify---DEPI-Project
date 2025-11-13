import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';
import 'package:taskify/features/services/data/services_model.dart';

class ServicesRepo {
  Future<Either<String, List<ServicesModel>>> getServices({
    required String category,
  }) async {
    final supabase = Supabase.instance.client;
    try {
      final response = await supabase
          .from(servicesTable)
          .select()
          .eq('category', category);
      final List<ServicesModel> services =
          (response as List).map((service) => ServicesModel.fromJson(service)).toList();
      return Right(services);
    } on PostgrestException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
