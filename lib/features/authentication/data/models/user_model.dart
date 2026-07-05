import 'package:equatable/equatable.dart';
import 'account_status.dart';

class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String displayName;
  final String username;
  final String zetraId;
  final String zetraNumber;
  final String? profileImage;
  final AccountStatus status;
  final DateTime createdAt;
  final DateTime? lastLogin;

  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      username: json['username'] as String? ?? '',
      zetraId: json['zetraId'] as String? ?? '',
      zetraNumber: json['zetraNumber'] as String? ?? '',
      profileImage: json['profileImage'] as String?,
      status: AccountStatus.fromString(json['status'] as String? ?? 'pending'),
      createdAt: json['createdAt'] is DateTime
          ? json['createdAt'] as DateTime
          : DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      lastLogin: json['lastLogin'] != null
          ? json['lastLogin'] is DateTime
              ? json['lastLogin'] as DateTime
              : DateTime.tryParse(json['lastLogin'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'displayName': displayName,
      'username': username,
      'zetraId': zetraId,
      'zetraNumber': zetraNumber,
      'profileImage': profileImage,
      'status': status.value,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? displayName,
    String? username,
    String? zetraId,
    String? zetraNumber,
    String? profileImage,
    AccountStatus? status,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      zetraId: zetraId ?? this.zetraId,
      zetraNumber: zetraNumber ?? this.zetraNumber,
      profileImage: profileImage ?? this.profileImage,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

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
