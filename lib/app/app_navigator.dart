import 'package:flutter/material.dart';
import 'package:zetra_id/features/authentication/presentation/pages/create_account_page.dart';
import 'package:zetra_id/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:zetra_id/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:zetra_id/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:zetra_id/features/profile/presentation/pages/profile_page.dart';
import 'package:zetra_id/features/settings/presentation/pages/settings_page.dart';
import 'package:zetra_id/features/welcome/presentation/pages/welcome_page.dart';

class AppNavigator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _createRoute(const WelcomePage());
      case '/create-account':
        return _createRoute(const CreateAccountPage());
      case '/sign-in':
        return _createRoute(const SignInPage());
      case '/forgot-password':
        return _createRoute(const ForgotPasswordPage());
      case '/profile':
        return _createRoute(const ProfilePage());
      case '/edit-profile':
        return _createRoute(const EditProfilePage());
      case '/settings':
        return _createRoute(const SettingsPage());
      default:
        return _createRoute(const WelcomePage());
    }
  }

  static Route<dynamic> _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
