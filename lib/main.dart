import 'package:flutter/material.dart';
import 'package:zetra_id/core/theme/app_theme.dart';
import 'package:zetra_id/features/welcome/presentation/pages/welcome_page.dart';

void main() {
  runApp(const ZetraApp());
}

class ZetraApp extends StatelessWidget {
  const ZetraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zetra ID',
      theme: AppTheme.light(),
      home: const WelcomePage(),
      useMaterial3: true,
    );
  }
}
