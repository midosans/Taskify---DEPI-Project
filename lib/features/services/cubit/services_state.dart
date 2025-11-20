import 'package:taskify/features/services/data/services_model.dart';

class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoadig extends ServicesState {}

class ServicesSuccess extends ServicesState {
  List<ServicesModel> services;
  ServicesSuccess({required this.services});
}

class ServicesFailure extends ServicesState {
  String errorMessage;
  ServicesFailure({required this.errorMessage});
}
