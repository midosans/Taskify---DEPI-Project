class UserdataModel {
  final String name;
  final String phone;
  final String? avatar;

  UserdataModel({
    required this.name,
    required this.phone,
     this.avatar,
  });

  factory UserdataModel.fromJson(Map<String, dynamic> json) {
    return UserdataModel(
      name: json['username'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }


}
