import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.email, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(email: json['email'], token: json['token']);
}
