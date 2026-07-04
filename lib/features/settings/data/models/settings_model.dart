import '../../domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({required super.darkMode});

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        darkMode: json['darkMode'] as bool? ?? false,
      );
}
