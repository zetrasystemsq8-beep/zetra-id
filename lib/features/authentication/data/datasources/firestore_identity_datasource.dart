import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zetra_id/features/authentication/data/models/user_model.dart';
import 'package:zetra_id/features/authentication/domain/entities/account_status.dart';
import 'package:zetra_id/features/authentication/domain/repositories/identity_repository.dart';
import 'package:zetra_id/core/utils/zetra_id_generator.dart';
import 'package:zetra_id/core/utils/zetra_number_generator.dart';

class FirestoreIdentityRepository implements IdentityRepository {
  final FirebaseFirestore _firestore;
  static const String _usersCollection = 'users';
  static const String _countersCollection = 'counters';
  static const String _zetraNumberCounter = 'zetra_number_sequence';

  FirestoreIdentityRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserModel> createUser({
    required String fullName,
    required String displayName,
    required String username,
    required String password,
  }) async {
    try {
      // Check if username already exists
      if (await usernameExists(username)) {
        throw Exception('Username already exists');
      }

      // Generate Zetra ID
      final zetraId = ZetraIdGenerator.generateZetraId(username);

      // Check if Zetra ID already exists
      if (await zetraIdExists(zetraId)) {
        throw Exception('Zetra ID already exists');
      }

      // Generate next Zetra Number
      final zetraNumber = await generateNextZetraNumber();

      // Create user document
      final userId = _firestore.collection(_usersCollection).doc().id;
      final now = DateTime.now();

      final userModel = UserModel(
        id: userId,
        fullName: fullName,
        displayName: displayName,
        username: username,
        zetraId: zetraId,
        zetraNumber: zetraNumber,
        profileImage: null,
        status: AccountStatus.pending,
        createdAt: now,
        lastLogin: null,
      );

      // Save to Firestore
      await _firestore.collection(_usersCollection).doc(userId).set(
            userModel.toJson(),
          );

      return userModel;
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    try {
      final docSnapshot =
          await _firestore.collection(_usersCollection).doc(userId).get();

      if (!docSnapshot.exists) {
        return null;
      }

      return UserModel.fromJson(docSnapshot.data() ?? {});
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    }
  }

  @override
  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return UserModel.fromJson(querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    }
  }

  @override
  Future<bool> usernameExists(String username) async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    }
  }

  @override
  Future<bool> zetraIdExists(String zetraId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('zetraId', isEqualTo: zetraId)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    }
  }

  @override
  Future<String> generateNextZetraNumber() async {
    try {
      final counterRef =
          _firestore.collection(_countersCollection).doc(_zetraNumberCounter);

      // Use a transaction to ensure atomic increment
      final newSequence = await _firestore.runTransaction((transaction) async {
        final counterDoc = await transaction.get(counterRef);

        late int currentSequence;
        if (!counterDoc.exists) {
          // Initialize counter at 1
          currentSequence = 1;
          transaction.set(counterRef, {'sequence': 1});
        } else {
          currentSequence = (counterDoc['sequence'] as int?) ?? 1;
          transaction.update(counterRef, {'sequence': currentSequence + 1});
        }

        return currentSequence;
      });

      return ZetraNumberGenerator.generateZetraNumber(newSequence);
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    }
  }

  @override
  Future<UserModel> updateProfile({
    required String userId,
    String? displayName,
    String? profileImage,
  }) async {
    try {
      final updates = <String, dynamic>{};

      if (displayName != null) {
        updates['displayName'] = displayName;
      }

      if (profileImage != null) {
        updates['profileImage'] = profileImage;
      }

      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .update(updates);

      final updatedUser = await getUserById(userId);
      if (updatedUser == null) {
        throw Exception('User not found after update');
      }

      return updatedUser;
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    }
  }

  @override
  Future<bool> deleteAccount(String userId) async {
    try {
      await _firestore.collection(_usersCollection).doc(userId).delete();
      return true;
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    }
  }
}
