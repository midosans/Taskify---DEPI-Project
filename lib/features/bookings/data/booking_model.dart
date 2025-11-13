class BookingModel {
  final String id;
  final String userId;
  final String status;
  final String? serviceId;
  final String? providerId;
  final String? providerName;
  final String? userName;
  final String? serviceTitel;
  final DateTime? date;
  final String? time;
  final String? address;
  final String? imageUrl;
  final double? price;

  BookingModel({
    required this.id,
    required this.userId,
    required this.status,
    this.serviceId,
    this.providerId,
    this.providerName,
    this.userName,
    this.serviceTitel,
    this.date,
    this.time,
    this.address,
    this.imageUrl,
    this.price,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      userId: map['user_id'],
      status: map['status'],
      serviceId: map['service_id'],
      providerId: map['provider_id'],
      providerName: map['provider_name'],
      userName: map['user_name'],
      serviceTitel: map['service_title'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      time: map['time'],
      address: map['address'],
      imageUrl: map['image_url'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'service_id': serviceId,
      'provider_id': providerId,
      'provider_name': providerName,
      'user_name': userName,
      'service_title': serviceTitel,
      'date': date?.toIso8601String(),
      'time': time,
      'address': address,
      'image_url': imageUrl,
      'price': price,
    };
  }
}
