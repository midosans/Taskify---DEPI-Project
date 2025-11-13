class ServicesModel {
  String? id;
  String? providerid;
  String? providername;
  String? category;
  String? title;
  String? description;
  String? photo;
  num? price;
  int? duration;
  String? avilablity;

  ServicesModel({
    this.id,
    this.providerid,
    this.providername,
    this.category,
    this.title,
    this.description,
    this.photo,
    this.price,
    this.duration,
    this.avilablity,
  });
  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      id: json['id'],
      providerid: json['providerid'],
      providername: json['providername'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      photo: json['photo'],
      price: json['price'],
      duration: json['duration'],
      avilablity: json['avilablity'],
    );
  }
}
