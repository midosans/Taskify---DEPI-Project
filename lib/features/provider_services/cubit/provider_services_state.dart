import 'package:taskify/features/provider_services/data/provider_services_model.dart';

class ProviderServicesState {}

class ProviderServicesInitial extends ProviderServicesState {}

class ProviderServicesLoading extends ProviderServicesState {}

class ProviderServicesSuccess extends ProviderServicesState {
  final List<ProviderServicesModel> providerServicesdata;
  ProviderServicesSuccess({required this.providerServicesdata});
}

class ProviderServicesFailure extends ProviderServicesState {
  final String errorMessage;

  ProviderServicesFailure({required this.errorMessage});
}
