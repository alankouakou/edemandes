import 'package:demandes/core/error/exceptions.dart';
import 'package:demandes/core/error/failures.dart';
import 'package:demandes/core/usecase.dart';
import 'package:demandes/features/authentification/domain/entities/user.dart';
import 'package:demandes/features/authentification/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignupParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(params) async {
    try {
      return await authRepository.signUpWithEmailAndPassword(
        name: params.name,
        email: params.email,
        password: params.password,
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

class UserSignupParams {
  final String email;
  final String password;
  final String name;

  UserSignupParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
