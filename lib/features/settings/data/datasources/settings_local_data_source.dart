import '../models/settings_model.dart';

class SettingsLocalDataSource {
  const SettingsLocalDataSource();

  Future<SettingsModel> loadSettings() async {
    return const SettingsModel(darkMode: false);
  }

  Future<void> saveSettings(SettingsModel settings) async {
    // placeholder
  }
}
