import 'package:demandes/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(
      Params params); // Future<SuccessType> call(Params params);
}
