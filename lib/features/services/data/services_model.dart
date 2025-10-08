class ServicesModel {
  int? id;
  int? providerid;
  String? providername;
  String category;
  String? title;
  String? description;
  String photo;
  num? price;
  String? duration;
  String? avilablity;

  ServicesModel({
    this.id,
    this.providerid,
    this.providername,
    required this.category,
    this.title,
    this.description,
    required this.photo,
    this.price,
    this.duration,
    this.avilablity,
  });
}

