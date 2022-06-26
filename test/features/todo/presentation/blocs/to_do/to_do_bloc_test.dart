import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/get_to_do_task_list_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/update_status_to_do_use_case.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';

import 'to_do_bloc_test.mocks.dart';

const unexpectedFailureMsg = "Unexpected Error";
const emptyToDoFailureMsg = 'Have no to do yet!';
const localDataSourceFailureMsg = 'Memory storage having problem';
@GenerateMocks([
  GetToDoListUseCase,
  UpdateStatusToDoUseCase,
])
void main() {
  late ToDoBloc toDoBloc;
  late GetToDoListUseCase getToDoListUseCase;
  late UpdateStatusToDoUseCase updateStatusToDoUseCase;
  setUp(() {
    getToDoListUseCase = MockGetToDoListUseCase();
    updateStatusToDoUseCase = MockUpdateStatusToDoUseCase();
    toDoBloc = ToDoBloc(
      getToDoListUseCase: getToDoListUseCase,
      updateStatusToDoUseCase: updateStatusToDoUseCase,
    );
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

  group('addToDoTask', () {
    const id = '1';
    const toDo =
        ToDoTask(id: id, name: 'coding', status: ToDoTaskStatus.complete);
    blocTest('Should emit ToDoStatusStatus success',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          bloc.add(const AddToDoTask(toDoTask: toDo));
        },
        expect: () => [
              state.copyWith(status: ToDoStateStatus.success, list: [toDo])
            ]);
  });

  group('updateToDoTask', () {
    const id = '1';
    const toDo =
        ToDoTask(id: id, name: 'coding', status: ToDoTaskStatus.complete);
    const statusChangeToDo =
        ToDoTask(id: id, name: 'coding', status: ToDoTaskStatus.incomplete);

    blocTest('Should emit ToDoLoaded',
        build: () => toDoBloc..add(const AddToDoTask(toDoTask: toDo)),
        act: (ToDoBloc bloc) {
          when(updateStatusToDoUseCase(const UpdateStatusToDoParams(id: id)))
              .thenAnswer((_) async => const Right(toDo));
          bloc.add(const UpdateToDoTaskEvent(id: id));
        },
        expect: () => [
              state.copyWith(list: [toDo], status: ToDoStateStatus.success),
              state.copyWith(status: ToDoStateStatus.loading, list: [toDo]),
              state.copyWith(
                  status: ToDoStateStatus.success, list: [statusChangeToDo])
            ]);
    blocTest('Should emit UnexpectedMsg into UpdateToDoError',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(updateStatusToDoUseCase(const UpdateStatusToDoParams(id: id)))
              .thenAnswer((_) async => Left(UnexpectedFailure()));
          bloc.add(const UpdateToDoTaskEvent(id: id));
        },
        expect: () => [
              stateLoading,
              state.copyWith(
                  errorMsg: unexpectedFailureMsg,
                  status: ToDoStateStatus.failure)
            ]);

    blocTest('Should emit LocalFailureMsg into UpdateToDoError',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) {
          when(updateStatusToDoUseCase(const UpdateStatusToDoParams(id: id)))
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
