class BookingModel {
  final String? id;
  final String? userId;
  final String? serviceId;
  final String? vendorId;
  final String? serviceImage;
  final String? serviceName;
  final String? vendorName;
  final String? userName;
  final double? price;
  final DateTime? bookingDate;
  final String? status;
  final String? address;

  BookingModel({
    this.id,
    this.userId,
    this.serviceId,
    this.vendorId,
    this.serviceImage,
    this.serviceName,
    this.vendorName,
    this.userName,
    this.price,
    this.bookingDate,
    this.status,
    this.address,
  });
}
