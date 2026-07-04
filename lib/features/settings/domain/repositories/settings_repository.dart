import '../entities/settings.dart';

abstract class SettingsRepository {
  Future<Settings> loadSettings();
  Future<void> saveSettings(Settings settings);
}
