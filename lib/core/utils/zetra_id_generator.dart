class ZetraIdGenerator {
  /// Generates Zetra ID from username
  /// Example: 'connect' -> 'connect@zetra'
  static String generateZetraId(String username) {
    if (username.isEmpty) {
      throw ArgumentError('Username cannot be empty');
    }
    return '$username@zetra';
  }

  /// Extracts username from Zetra ID
  /// Example: 'connect@zetra' -> 'connect'
  static String extractUsernameFromZetraId(String zetraId) {
    if (!zetraId.endsWith('@zetra')) {
      throw ArgumentError('Invalid Zetra ID format');
    }
    return zetraId.replaceAll('@zetra', '');
  }

  /// Validates Zetra ID format
  static bool isValidZetraId(String zetraId) {
    return RegExp(r'^[a-z0-9_]+@zetra$').hasMatch(zetraId);
  }
}
