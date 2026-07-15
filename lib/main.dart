import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zetra_id/core/theme/app_theme.dart';
import 'package:zetra_id/app/app_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ZetraApp());
}

class ZetraApp extends StatelessWidget {
  const ZetraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zetra ID',
      theme: AppTheme.dark(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      onGenerateRoute: AppNavigator.generateRoute,
      initialRoute: '/',
      useMaterial3: true,
    );
  }
}
