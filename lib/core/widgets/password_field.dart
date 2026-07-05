import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final ValueChanged<double>? onStrengthChanged;

  const PasswordField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.onChanged,
    this.hintText,
    this.onStrengthChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;
  late FocusNode _focusNode;
  bool _isFocused = false;
  double _passwordStrength = 0;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller?.addListener(_calculateStrength);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    widget.controller?.removeListener(_calculateStrength);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _calculateStrength() {
    final password = widget.controller?.text ?? '';
    double strength = 0;

    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]')) || password.contains(RegExp(r'[!@#$%^&*]'))) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
    });
    widget.onStrengthChanged?.call(strength);
  }

  Color _getStrengthColor() {
    if (_passwordStrength < 0.25) return Colors.red;
    if (_passwordStrength < 0.5) return Colors.orange;
    if (_passwordStrength < 0.75) return Colors.yellow;
    return const Color(0xFF00B894);
  }

  String _getStrengthText() {
    if (_passwordStrength < 0.25) return 'Weak';
    if (_passwordStrength < 0.5) return 'Fair';
    if (_passwordStrength < 0.75) return 'Good';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          validator: widget.validator,
          onChanged: (value) {
            _calculateStrength();
            widget.onChanged?.call(value);
          },
          obscureText: _isObscured,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.white60,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
        ),
        if (widget.controller?.text.isNotEmpty ?? false) ...[_buildStrengthIndicator()],
      ],
    );
  }

  Widget _buildStrengthIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _passwordStrength,
                    minHeight: 4,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation<Color>(_getStrengthColor()),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _getStrengthText(),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _getStrengthColor(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
