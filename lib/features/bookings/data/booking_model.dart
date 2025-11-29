class BookingModel {
  final String? id;
  final String userId;
  final String status;
  final String? serviceId;
  final String? providerId;
  final String? providerName;
  final String? userName;
  final String? serviceTitle;
  final DateTime? date;   // keep this 
  final String? time;     // <-- FIXED: time is string
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
    this.serviceTitle,
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
      userName: map['username'],
      serviceTitle: map['service_title'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      time: map['time'],   // now correct type
      address: map['address'],
      imageUrl: map['photo_url'],
      price: map['price'],
    );
  }
}
