abstract class IdentityRepository {
  /// Creates a new user account
  /// Returns the created UserModel
  Future<dynamic> createUser({
    required String fullName,
    required String displayName,
    required String username,
    required String password,
  });

  /// Retrieves a user by ID
  /// Returns the UserModel or null if not found
  Future<dynamic> getUserById(String userId);

  /// Retrieves a user by username
  /// Returns the UserModel or null if not found
  Future<dynamic> getUserByUsername(String username);

  /// Checks if username already exists
  /// Returns true if username is taken, false otherwise
  Future<bool> usernameExists(String username);

  /// Checks if Zetra ID already exists
  /// Returns true if Zetra ID is taken, false otherwise
  Future<bool> zetraIdExists(String zetraId);

  /// Generates the next available Zetra Number
  /// Returns the next Zetra Number in sequence
  Future<String> generateNextZetraNumber();

  /// Updates user profile information
  /// Returns the updated UserModel
  Future<dynamic> updateProfile({
    required String userId,
    String? displayName,
    String? profileImage,
  });

  /// Deletes a user account permanently
  /// Returns true if successful, false otherwise
  Future<bool> deleteAccount(String userId);

  /// Gets all users (admin only)
  /// Returns a list of UserModels
  Future<List<dynamic>> getAllUsers();
}
