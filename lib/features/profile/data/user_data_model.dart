class UserdataModel {
  final String name;
  final String phone;
  final String? avatar;
  final String role;

  UserdataModel({
    required this.name,
    required this.phone,
    required this.role,
     this.avatar,
  });

  factory UserdataModel.fromJson(Map<String, dynamic> json) {
    return UserdataModel(
      name: json['username'],
      phone: json['phone'],
      role: json['role'],
      avatar: json['avatar'],
    );
  }


}
