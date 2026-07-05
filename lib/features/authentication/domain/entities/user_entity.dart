import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String displayName;
  final String username;
  final String zetraId;
  final String zetraNumber;
  final String? profileImage;
  final String status;
  final DateTime createdAt;
  final DateTime? lastLogin;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.displayName,
    required this.username,
    required this.zetraId,
    required this.zetraNumber,
    this.profileImage,
    required this.status,
    required this.createdAt,
    this.lastLogin,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        displayName,
        username,
        zetraId,
        zetraNumber,
        profileImage,
        status,
        createdAt,
        lastLogin,
      ];
}
