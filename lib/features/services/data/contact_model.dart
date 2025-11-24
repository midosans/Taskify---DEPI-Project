class ContactModel {
  final String phone;
  final String? avatar;

  ContactModel({
    required this.phone,
    this.avatar,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      phone: json['phone'] as String,
      avatar: json['avatar'] as String?,
    );
  }
}