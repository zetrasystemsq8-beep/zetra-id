import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required String id, required String email})
      : super(id: id, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String? ?? '',
        email: json['email'] as String? ?? '',
      );
}
