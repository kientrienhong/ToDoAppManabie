import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/utils/validate_input.dart';

void main() {
  late ValidateInput validateInput;

  setUp(() {
    validateInput = ValidateInput();
  });

  group('valid name to do', () {
    test('Should return valid String', () {
      const validString = 'coding';

      final response = validateInput.validateName(validString);

      expect(response, equals(const Right(validString)));
    });

    test('Should return EmptyNameFailure when receive empty string', () {
      const inValidString = '';

      final response = validateInput.validateName(inValidString);

      expect(response, equals(Left(EmptyNameFailure())));
    });

    test('Should return EmptyNameFailure when receive string will only space',
        () {
      const inValidString = ' ';

      final response = validateInput.validateName(inValidString);

      expect(response, equals(Left(EmptyNameFailure())));
    });
  });
}
