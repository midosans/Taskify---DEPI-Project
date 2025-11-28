import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/features/provider_services/cubit/delete_service_state.dart';
import 'package:taskify/features/provider_services/data/delete_service_repo.dart';

class DeleteServiceCubit extends Cubit<DeleteServiceState> {
  DeleteServiceCubit({required this.deleteServiceRepo})
    : super((DeleteServiceInitial()));
  final DeleteServiceRepo deleteServiceRepo;
  void deleteService({required String id,}) async {
    emit(DeleteServiceLoading());
    bool connected = await hasInternet();
    if(connected == true){
    try {
      deleteServiceRepo.deleteService(id);
      emit(DeleteServiceSuccess());
    } catch (e) {
      emit(DeleteServiceFailure(errorMessage: e.toString()));
    }
  }else{
    emit(DeleteServiceFailure(errorMessage: 'no_internet_connection'.tr()));
  }
  }
}
