import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'provider_services_state.dart';

class ProviderServicesCubit extends Cubit<ProviderServicesState> {
  ProviderServicesCubit() : super(ProviderServicesInitial());
}
