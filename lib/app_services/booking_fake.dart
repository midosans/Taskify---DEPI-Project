import 'package:taskify/features/bookings/data/booking_model.dart';

extension BookingFake on BookingModel {
  static BookingModel fake() {
    return BookingModel(
      id: "loading-id",
      userId: "loading-user",
      status: "loading",
      serviceId: "loading-service",
      providerId: "loading-provider",
      providerName: "Loading...",
      userName: "Loading...",
      serviceTitle: "Loading title...",
      date: DateTime.now(), // keep this
      time: "Loading...",   // string placeholder
      address: "Loading...",
      imageUrl: "",          // empty → skeleton block instead of an image
      price: 0.0,
    );
  }
}