import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/core/api_helper.dart';
import 'package:taskify/features/provider_services/data/provider_services_model.dart';

class ProviderServicesRepo {
  Future<Either<String, List<ProviderServicesModel>>> getServices() async {
    final connected = await hasInternet();
    if (!connected) {
      return const Left('no_internet_connection');
    }

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

      final services = response
          .map<ProviderServicesModel>((data) =>
              ProviderServicesModel.fromJson(data))
          .toList();

      return Right(services);
    } on PostgrestException catch (e) {
      return Left("Supabase error: ${e.message}");
    } catch (e) {
      return Left("Unexpected error: $e");
    }
  }
}
