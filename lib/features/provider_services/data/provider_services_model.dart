class ProviderServicesModel {
  String? providername;
  String? category;
  String? title;
  String? description;
  String? photo;
  num? price;
  num? duration;
  bool? avilablity;

  ProviderServicesModel({
    this.providername,
    this.category,
    this.title,
    this.description,
    this.photo,
    this.price,
    this.duration,
    this.avilablity,
  });

  factory ProviderServicesModel.fromJson(Map<String, dynamic> json) {
    return ProviderServicesModel(
      providername: json['provider_name'] as String?,
      category: json['category'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
      price: json['price'] as num?,
      duration: json['duration'] as num?,
      avilablity: json['availability'] as bool?,
    );
  }
}
