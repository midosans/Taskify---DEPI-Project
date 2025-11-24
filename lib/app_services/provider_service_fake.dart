import 'package:taskify/features/provider_services/data/provider_services_model.dart';

extension ServiceFake on ProviderServicesModel {
  static ProviderServicesModel fake() {
    return ProviderServicesModel(
      id: "loading-id",
      providername: "Loading...",
      category: "Loading...",
      title: "Loading title...",
      description: "Loading description...",
      photo: "", // empty so it becomes a grey skeleton block
      price: 0,
      duration: 0,
    );
  }
}
