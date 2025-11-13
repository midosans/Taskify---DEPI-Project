import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/provider_services/cubit/update_service_state.dart';
import 'package:taskify/features/provider_services/data/update_service_repo.dart';

class UpdateServiceCubit extends Cubit<UpdateServiceState> {
  UpdateServiceCubit({required this.updateServiceRepo})
    : super((UpdateServiceInitial()));
  final UpdateServiceRepo updateServiceRepo;
  void deleteService({
    required int id,
    String? name,
    String? photoUrl,
    String? description,
    double? price,
    bool? availability,
  }) async {
    emit(UpdateServiceLoading());
    try {
      updateServiceRepo.updateService(
        id,
        name,
        photoUrl,
        description,
        price,
        availability,
      );
      emit(UpdateServiceSuccess());
    } catch (e) {
      emit(UpdateServiceFailure(errorMessage: e.toString()));
    }
  }
}
