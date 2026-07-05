import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zetra_id/core/widgets/widgets.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isFormValid = false;
  double _passwordStrength = 0;

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(_validateForm);
    _displayNameController.addListener(_validateForm);
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _fullNameController.text.isNotEmpty &&
          _displayNameController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text &&
          _passwordStrength >= 0.5;
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _displayNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Zetra ID',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Full Name',
                  hintText: 'John Doe',
                  controller: _fullNameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Full name is required';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Display Name',
                  hintText: 'johndoe',
                  controller: _displayNameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Display name is required';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Username',
                  hintText: 'johndoe',
                  controller: _usernameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Username is required';
                    if ((value?.length ?? 0) < 3) return 'Username must be at least 3 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1F2E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2D3748)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Zetra ID',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_usernameController.text}@zetra',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00B894),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                PasswordField(
                  label: 'Password',
                  hintText: 'Enter a strong password',
                  controller: _passwordController,
                  onStrengthChanged: (strength) {
                    setState(() {
                      _passwordStrength = strength;
                    });
                    _validateForm();
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Password is required';
                    if ((value?.length ?? 0) < 8) return 'Password must be at least 8 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please confirm your password';
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  label: 'Create Zetra ID',
                  isEnabled: _isFormValid,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account created successfully!')),
                      );
                      Navigator.of(context).pushNamed('/profile');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}