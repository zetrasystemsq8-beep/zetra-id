class ZetraNumberGenerator {
  /// Generates Zetra Number with format ZT000001
  /// Input: sequence number starting from 1
  /// Output: ZT000001, ZT000002, etc.
  static String generateZetraNumber(int sequenceNumber) {
    if (sequenceNumber <= 0) {
      throw ArgumentError('Sequence number must be greater than 0');
    }

    // Format: ZT followed by 6-digit zero-padded number
    final paddedNumber = sequenceNumber.toString().padLeft(6, '0');
    return 'ZT$paddedNumber';
  }

  /// Extracts sequence number from Zetra Number
  /// Input: ZT000001
  /// Output: 1
  static int extractSequenceNumber(String zetraNumber) {
    if (!isValidZetraNumber(zetraNumber)) {
      throw ArgumentError('Invalid Zetra Number format');
    }
    final numberPart = zetraNumber.replaceAll('ZT', '');
    return int.parse(numberPart);
  }

  /// Validates Zetra Number format
  static bool isValidZetraNumber(String zetraNumber) {
    return RegExp(r'^ZT\d{6}$').hasMatch(zetraNumber);
  }

  /// Gets the next Zetra Number
  static String getNextZetraNumber(String currentZetraNumber) {
    final currentSequence = extractSequenceNumber(currentZetraNumber);
    return generateZetraNumber(currentSequence + 1);
  }
}
