import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/provider_services/cubit/provider_services_state.dart';
import 'package:taskify/features/provider_services/data/provider_services_repo.dart';

class ProviderServicesCubit extends Cubit<ProviderServicesState> {
  ProviderServicesCubit({required this.providerServicesRepo})
    : super(ProviderServicesInitial());
  final ProviderServicesRepo providerServicesRepo;

  void fetchData() async {
    emit(ProviderServicesLoading());
    final response = await providerServicesRepo.getServices();
    response.fold(
      (errormessage) => emit(ProviderServicesFailure(errorMessage: errormessage)),
      (response) => emit(ProviderServicesSuccess( providerServicesdata:response )),
    );
  }
}
