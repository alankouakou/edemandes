import 'package:demandes/core/error/exceptions.dart';
import 'package:demandes/core/error/failures.dart';
import 'package:demandes/core/usecase/usecase.dart';
import 'package:demandes/features/authentification/domain/entities/user.dart';
import 'package:demandes/features/authentification/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    try {
      return await authRepository.loginWithEmailAndPassword(
          email: params.email, password: params.password);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
