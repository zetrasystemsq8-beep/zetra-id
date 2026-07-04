import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({required super.id, required super.name, required super.email});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
      );
}
