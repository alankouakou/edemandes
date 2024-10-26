import 'package:demandes/core/error/exceptions.dart';
import 'package:demandes/core/error/failures.dart';
import 'package:demandes/features/authentification/data/datasources/auth_remote_datasource.dart';
import 'package:demandes/features/authentification/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AutRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  const AutRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId = await authRemoteDatasource.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
