import '../../domain/entities/welcome_message.dart';

class WelcomeModel extends WelcomeMessage {
  const WelcomeModel(String message) : super(message);

  factory WelcomeModel.fromJson(Map<String, dynamic> json) =>
      WelcomeModel(json['message'] as String? ?? 'Welcome to Zetra ID');
}
