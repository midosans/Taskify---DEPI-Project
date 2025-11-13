import 'package:taskify/features/services/data/services_model.dart';

class ServicesState {}

final class ServicesInitial extends ServicesState {}
final class ServicesLoadig extends ServicesState {}
final class ServicesSuccess extends ServicesState {
  List<ServicesModel> services;
  ServicesSuccess({required this.services});
}
final class ServicesFailure extends ServicesState {
  String errorMessage;
  ServicesFailure({required this.errorMessage});
}
