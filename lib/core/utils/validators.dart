class UsernameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 4) {
      return 'Username must be at least 4 characters';
    }

    if (value.length > 20) {
      return 'Username must not exceed 20 characters';
    }

    if (!RegExp(r'^[a-z0-9_]+$').hasMatch(value)) {
      return 'Username must contain only lowercase letters, numbers, and underscores';
    }

    if (value.startsWith('_') || value.endsWith('_')) {
      return 'Username cannot start or end with an underscore';
    }

    return null;
  }
}

class FullNameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }

    if (value.length < 2) {
      return 'Full name must be at least 2 characters';
    }

    if (value.length > 50) {
      return 'Full name must not exceed 50 characters';
    }

    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      return 'Full name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }
}

class DisplayNameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Display name is required';
    }

    if (value.length < 2) {
      return 'Display name must be at least 2 characters';
    }

    if (value.length > 30) {
      return 'Display name must not exceed 30 characters';
    }

    return null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (value.length > 128) {
      return 'Password must not exceed 128 characters';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  static double calculateStrength(String password) {
    double strength = 0;

    if (password.length >= 8) strength += 0.2;
    if (password.length >= 12) strength += 0.1;
    if (RegExp(r'[a-z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.15;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.15;

    return strength.clamp(0, 1);
  }
}
