import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CreateZetraIdUseCase {
  final AuthRepository repository;

  const CreateZetraIdUseCase(this.repository);

  Future<UserEntity> call(UserEntity user) async {
    return repository.createAccount(user);
  }
}
