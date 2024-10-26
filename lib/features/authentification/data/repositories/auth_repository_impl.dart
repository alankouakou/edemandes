import 'package:demandes/core/error/exceptions.dart';
import 'package:demandes/core/error/failures.dart';
import 'package:demandes/features/authentification/data/datasources/auth_remote_datasource.dart';
import 'package:demandes/features/authentification/domain/entities/user.dart';
import 'package:demandes/features/authentification/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  const AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await authRemoteDatasource.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
