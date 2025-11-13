import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/services/cubit/services_state.dart';
import 'package:taskify/features/services/data/services_repo.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit({required this.servicesRepo}) : super(ServicesInitial());
  ServicesRepo servicesRepo = ServicesRepo();
  void getServices({required String category}) async {
    emit(ServicesLoadig());
    final result = await servicesRepo.getServices(category: category);
    result.fold(
      (message) => emit(ServicesFailure(errorMessage: message)),
      (services) => emit(ServicesSuccess(services: services)),
    );
  }
}
