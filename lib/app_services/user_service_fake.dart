
import 'package:taskify/features/services/data/services_model.dart';

extension UserServiceFake on ServicesModel {
  static ServicesModel fake() {
    return ServicesModel(
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
