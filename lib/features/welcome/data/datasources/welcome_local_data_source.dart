import '../models/welcome_model.dart';

class WelcomeLocalDataSource {
  const WelcomeLocalDataSource();

  Future<WelcomeModel> loadMessage() async {
    // placeholder implementation
    return const WelcomeModel('Welcome to Zetra ID');
  }
}
