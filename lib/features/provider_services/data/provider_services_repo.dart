import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';
import 'package:taskify/features/provider_services/data/provider_services_model.dart';

class ProviderServicesRepo {
  Future<Either<String, List<ProviderServicesModel>>> getServices() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      return const Left("Please log in again.");
    }

    try {
      final response = await supabase
          .from(servicesTable)
          .select()
          .eq('provider_id', user.id);

      // // handle unexpected format (Supabase returns a List<dynamic>)
      // if (response is! List) {
      //   return const Left("Unexpected response format from server.");
      // }

      final services = response
          .map<ProviderServicesModel>(
            (data) => ProviderServicesModel.fromJson(data),
          )
          .toList();

      return Right(services);
    } on PostgrestException catch (e) {
      // Supabase-specific errors (e.g., permission denied)
      return Left("Supabase error: ${e.message}");
    } catch (e) {
      // any other runtime error (e.g., network, parsing)
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}

