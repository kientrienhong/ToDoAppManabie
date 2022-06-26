import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/utils/validate_input.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/create_to_do_task_use_case.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/create_to_do/create_to_do_bloc.dart';

import 'create_to_do_bloc_test.mocks.dart';

const unexpectedFailureMsg = "Unexpected Error";
const existedNameFailureMsg = 'Existed name! Please provide another one';
const emptyToDoFailureMsg = 'Have no to do yet!';
const localDataSourceFailureMsg = 'Memory storage having problem';
const emptyNameFailureMsg = 'Please provide name';

@GenerateMocks([CreateToDoUseCase, ValidateInput])
void main() {
  late CreateToDoBloc createToDoBloc;
  late CreateToDoUseCase createToDoUseCase;
  late ValidateInput validateInput;

  setUp(() {
    createToDoUseCase = MockCreateToDoUseCase();
    validateInput = MockValidateInput();

    createToDoBloc = CreateToDoBloc(
        createToDoUseCase: createToDoUseCase, validateInput: validateInput);
  });

  group('createToDoTask', () {
    const name = 'cleaning house';
    const toDo =
        ToDoTask(id: '3', name: name, status: ToDoTaskStatus.incomplete);
    const existedName = 'coding';
    blocTest('Should emit CreateToDoLoaded',
        build: () => createToDoBloc,
        act: (CreateToDoBloc bloc) {
          when(validateInput.validateName(name))
              .thenAnswer((_) => const Right(name));
          when(createToDoUseCase(const CreateToDoUseCaseParam(name: name)))
              .thenAnswer((_) async => const Right(toDo));
          bloc.add(const CreateToDoEvent(name));
        },
        expect: () =>
            [CreateToDoLoading(), const CreateToDoLoaded(task: toDo)]);

    blocTest('Should emit EmptyNameMsg into CreateToDoError',
        build: () => createToDoBloc,
        act: (CreateToDoBloc bloc) {
          when(validateInput.validateName(''))
              .thenAnswer((_) => Left(EmptyNameFailure()));

          bloc.add(const CreateToDoEvent(''));
        },
        expect: () => [
              CreateToDoLoading(),
              const CreateToDoError(error: emptyNameFailureMsg)
            ]);

    blocTest('Should emit ExistedNameMsg into CreateToDoError',
        build: () => createToDoBloc,
        act: (CreateToDoBloc bloc) {
          when(validateInput.validateName(existedName))
              .thenAnswer((_) => const Right(existedName));
          when(createToDoUseCase(
                  const CreateToDoUseCaseParam(name: existedName)))
              .thenAnswer((_) async => Left(ExistedNameFailure()));
          bloc.add(const CreateToDoEvent(existedName));
        },
        expect: () => [
              CreateToDoLoading(),
              const CreateToDoError(error: existedNameFailureMsg)
            ]);
    blocTest('Should emit LocalFailureMsg into CreateToDoError',
        build: () => createToDoBloc,
        act: (CreateToDoBloc bloc) {
          when(validateInput.validateName(name))
              .thenAnswer((_) => const Right(name));
          when(createToDoUseCase(const CreateToDoUseCaseParam(name: name)))
              .thenAnswer((_) async => Left(LocalFailure()));
          bloc.add(const CreateToDoEvent(name));
        },
        expect: () => [
              CreateToDoLoading(),
              const CreateToDoError(error: localDataSourceFailureMsg)
            ]);
    blocTest('Should emit UnExpectedMsg into CreateToDoError',
        build: () => createToDoBloc,
        act: (CreateToDoBloc bloc) {
          when(validateInput.validateName(name))
              .thenAnswer((_) => const Right(name));
          when(createToDoUseCase(const CreateToDoUseCaseParam(name: name)))
              .thenAnswer((_) async => Left(UnexpectedFailure()));
          bloc.add(const CreateToDoEvent(name));
        },
        expect: () => [
              CreateToDoLoading(),
              const CreateToDoError(error: unexpectedFailureMsg)
            ]);
  });
}
