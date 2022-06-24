import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';

class ValidateInput {
  Either<Failure, String> validateName(String name) {
    if (name.isEmpty) {
      return Left(EmptyNameFailure());
    }

    return Right(name);
  }
}
