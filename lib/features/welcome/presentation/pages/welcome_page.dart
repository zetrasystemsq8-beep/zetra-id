import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zetra_id/core/widgets/widgets.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    AppLogo(size: 100, animate: true),
                    const SizedBox(height: 40),
                    Text(
                      'Welcome to Zetra ID',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'One identity for every Zetra application.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 60),
                    PrimaryButton(
                      label: 'Create Zetra ID',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/create-account');
                      },
                    ),
                    const SizedBox(height: 16),
                    SecondaryButton(
                      label: 'Sign In',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/sign-in');
                      },
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Terms of Service',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF00B894),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          ' • ',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white30,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Privacy Policy',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF00B894),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}