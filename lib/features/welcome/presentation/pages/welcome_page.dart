import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zetra ID')),
      body: const Center(
        child: Text(
          'Welcome to Zetra ID',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
