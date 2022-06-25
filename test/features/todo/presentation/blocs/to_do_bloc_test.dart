import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
import 'package:to_do_app_manabie/core/utils/validate_input.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/create_to_do_task_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/get_to_do_task_list_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/update_status_to_do_use_case.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';

import 'to_do_bloc_test.mocks.dart';

const unExpectedFailureMsg = "Unexpected Error";
const existedNameFailureMsg = 'Existed name! Please provide another one';
const emptyToDoFailureMsg = 'Have no to do yet!';
const localDataSourceFailureMsg = 'Memory storage having problem';
const emptyNameFailureMsg = 'Please provide name';
@GenerateMocks([
  GetToDoListUseCase,
  UpdateStatusToDoUseCase,
  CreateToDoUseCase,
  ValidateInput
])
void main() {
  late ToDoBloc toDoBloc;
  late GetToDoListUseCase getToDoListUseCase;
  late CreateToDoUseCase createToDoUseCase;
  late UpdateStatusToDoUseCase updateStatusToDoUseCase;
  late ValidateInput validateInput;
  setUp(() {
    getToDoListUseCase = MockGetToDoListUseCase();
    createToDoUseCase = MockCreateToDoUseCase();
    updateStatusToDoUseCase = MockUpdateStatusToDoUseCase();
    validateInput = MockValidateInput();
    toDoBloc = ToDoBloc(
        getToDoListUseCase: getToDoListUseCase,
        createToDoUseCase: createToDoUseCase,
        updateStatusToDoUseCase: updateStatusToDoUseCase,
        validateInput: validateInput);
  });
  const listToDoTask = [
    ToDoTask(id: '1', name: 'coding', status: ToDoTaskStatus.complete),
    ToDoTask(
        id: '2', name: 'doing homework', status: ToDoTaskStatus.incomplete),
  ];
  ToDoState state = ToDoState.initial();
  ToDoState stateLoading = state.copyWith(status: ToDoStateStatus.loading);
  group('getListToDo', () {
    blocTest('Should emit ToDoTaskList into ToDoLoaded',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) async {
          when(getToDoListUseCase(NoParams()))
              .thenAnswer((_) async => const Right(listToDoTask));
          bloc.add(GetToDoTaskListEvent());
        },
        expect: () {
          return [
            stateLoading,
            state.copyWith(status: ToDoStateStatus.success, list: listToDoTask)
          ];
        });

    blocTest('Should emit Error',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) async {
          when(getToDoListUseCase(NoParams()))
              .thenAnswer((_) async => Left(EmptyToDoFailure()));
          bloc.add(GetToDoTaskListEvent());
        },
        expect: () {
          return [
            stateLoading,
            state.copyWith(
                errorMsg: emptyToDoFailureMsg, status: ToDoStateStatus.failure)
          ];
        });
  });

  group('createToDoTask', () {
    const name = 'cleaning house';
    const toDo =
        ToDoTask(id: '3', name: name, status: ToDoTaskStatus.incomplete);
    const existedName = 'coding';
    blocTest('Should emit CreateToDoLoaded',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(validateInput.validateName(name))
              .thenAnswer((_) => const Right(name));
          when(createToDoUseCase(const CreateToDoUseCaseParam(name: name)))
              .thenAnswer((_) async => const Right(toDo));
          bloc.add(const CreateToDoTaskEvent(name: name));
        },
        expect: () => [
              stateLoading,
              state.copyWith(status: ToDoStateStatus.success, list: [toDo])
            ]);

    blocTest('Should emit EmptyNameMsg into CreateToDoError',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(validateInput.validateName(''))
              .thenAnswer((_) => Left(EmptyNameFailure()));

          bloc.add(const CreateToDoTaskEvent(name: ''));
        },
        expect: () => [
              stateLoading,
              state.copyWith(
                  errorMsg: emptyNameFailureMsg,
                  status: ToDoStateStatus.failure)
            ]);

    blocTest('Should emit ExistedNameMsg into CreateToDoError',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(validateInput.validateName(existedName))
              .thenAnswer((_) => const Right(existedName));
          when(createToDoUseCase(
                  const CreateToDoUseCaseParam(name: existedName)))
              .thenAnswer((_) async => Left(ExistedNameFailure()));
          bloc.add(const CreateToDoTaskEvent(name: existedName));
        },
        expect: () => [
              stateLoading,
              state.copyWith(
                  errorMsg: existedNameFailureMsg,
                  status: ToDoStateStatus.failure)
            ]);
    blocTest('Should emit LocalFailureMsg into CreateToDoError',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(validateInput.validateName(name))
              .thenAnswer((_) => const Right(name));
          when(createToDoUseCase(const CreateToDoUseCaseParam(name: name)))
              .thenAnswer((_) async => Left(LocalFailure()));
          bloc.add(const CreateToDoTaskEvent(name: name));
        },
        expect: () => [
              stateLoading,
              state.copyWith(
                  errorMsg: localDataSourceFailureMsg,
                  status: ToDoStateStatus.failure)
            ]);
    blocTest('Should emit UnExpectedMsg into CreateToDoError',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(validateInput.validateName(name))
              .thenAnswer((_) => const Right(name));
          when(createToDoUseCase(const CreateToDoUseCaseParam(name: name)))
              .thenAnswer((_) async => Left(UnexpectedFailure()));
          bloc.add(const CreateToDoTaskEvent(name: name));
        },
        expect: () => [
              stateLoading,
              state.copyWith(
                  errorMsg: unExpectedFailureMsg,
                  status: ToDoStateStatus.failure)
            ]);
  });

  group('updateToDoTask', () {
    const id = '1';
    const toDo =
        ToDoTask(id: id, name: 'coding', status: ToDoTaskStatus.complete);

    blocTest('Should emit ToDoLoaded',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(updateStatusToDoUseCase(UpdateStatusToDoParams(id: id)))
              .thenAnswer((_) async => const Right(toDo));
          bloc.add(const UpdateToDoTaskEvent(id: id));
        },
        expect: () => [stateLoading]);
    blocTest('Should emit UnExpectedMsg into UpdateToDoError',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(updateStatusToDoUseCase(UpdateStatusToDoParams(id: id)))
              .thenAnswer((_) async => Left(UnexpectedFailure()));
          bloc.add(const UpdateToDoTaskEvent(id: id));
        },
        expect: () => [
              stateLoading,
              state.copyWith(
                  errorMsg: unExpectedFailureMsg,
                  status: ToDoStateStatus.failure)
            ]);

    blocTest('Should emit LocalFailureMsg into UpdateToDoError',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(updateStatusToDoUseCase(UpdateStatusToDoParams(id: id)))
              .thenAnswer((_) async => Left(LocalFailure()));
          bloc.add(const UpdateToDoTaskEvent(id: id));
        },
        expect: () => [
              stateLoading,
              state.copyWith(
                  errorMsg: localDataSourceFailureMsg,
                  status: ToDoStateStatus.failure)
            ]);
  });
}
