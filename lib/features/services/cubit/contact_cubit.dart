import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/app_services/internet_checker.dart';
import 'package:taskify/features/services/cubit/contact_state.dart';
import 'package:taskify/features/services/data/contact_repo.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit({required this.contactRepo}) : super(ContactInitial());
  final ContactRepo contactRepo;
  Future<void> getPhone({required String providerId}) async {
    emit(ContactLoading());
    bool connected = await hasInternet();
    if (connected) {
      try {
        final contact = await contactRepo.getPhone(providerId);
        if (contact == null) {
          emit(ContactFailure(errorMessage: 'No contact data found'));
          return;
        }
        emit(ContactSuccess(contactModel: contact));
      } catch (e) {
        emit(ContactFailure(errorMessage: e.toString()));
      }
    } else {
      emit(ContactFailure(errorMessage: 'no_internet_connection'.tr()));
    }
  }
}
