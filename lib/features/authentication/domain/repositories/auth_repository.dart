import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Creates a new Zetra account.
  Future<UserEntity> createAccount(UserEntity user);

  /// Signs in using Zetra ID or username.
  Future<UserEntity?> signIn({
    required String zetraIdOrUsername,
    required String password,
  });

  /// Signs out the current user.
  Future<void> signOut();

  /// Returns the currently signed-in user.
  Future<UserEntity?> getCurrentUser();

  /// Checks whether a username is already taken.
  Future<bool> isUsernameAvailable(String username);

  /// Checks whether a Zetra ID already exists.
  Future<bool> isZetraIdAvailable(String zetraId);

  /// Updates an existing user profile.
  Future<UserEntity> updateProfile(UserEntity user);
}
