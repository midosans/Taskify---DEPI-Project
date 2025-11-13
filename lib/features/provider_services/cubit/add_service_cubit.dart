import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/provider_services/cubit/add_service_state.dart';
import 'package:taskify/features/provider_services/data/add_service_repo.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit({required this.addServiceRepo}) : super(AddServiceInitial());
  final AddServiceRepo addServiceRepo;
  void addService({
    required String title,
    required String description,
    required double price,
    required File photo,
  }) async {
    emit(AddServiceLoading());
    try {
      addServiceRepo.addService(
        title: title,
        description: description,
        price: price,
        photo: photo,
      );
      emit(AddServiceSuccess());
    } catch (e) {
      emit(AddServiceFailure(errorMessage: e.toString()));
    }
  }
}
