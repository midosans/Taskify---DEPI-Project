import 'package:taskify/features/services/data/contact_model.dart';

class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final ContactModel contactModel;
  ContactSuccess({required this.contactModel});
}

class ContactFailure extends ContactState {
  final String errorMessage;
  ContactFailure({required this.errorMessage});
}
