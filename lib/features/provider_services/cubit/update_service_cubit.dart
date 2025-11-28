import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/features/provider_services/cubit/update_service_state.dart';
import 'package:taskify/features/provider_services/data/update_service_repo.dart';

class UpdateServiceCubit extends Cubit<UpdateServiceState> {
  UpdateServiceCubit({required this.updateServiceRepo})
    : super((UpdateServiceInitial()));
  final UpdateServiceRepo updateServiceRepo;
  void updateService({
    required String id,
    String? title,
    String? description,
    double? price,
    File? photo,
    bool? availability,
  }) async {
    emit(UpdateServiceLoading());
    bool connected = await hasInternet();
    if(connected == true){
    try {
      updateServiceRepo.updateService(
      id,
      title,
      description,
      price,
      photo,
      );
      emit(UpdateServiceSuccess());
    } catch (e) {
      emit(UpdateServiceFailure(errorMessage: e.toString()));
    }
  }else{
    emit(UpdateServiceFailure(errorMessage: 'no_internet_connection'.tr()));
  }
  }
}
