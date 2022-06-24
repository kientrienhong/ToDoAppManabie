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

const expectedFailureMsg = "Unexpected Error";
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

  group('getListToDo', () {
    const listToDoTask = [
      ToDoTask(id: '1', name: 'coding', status: ToDoTaskStatus.done),
      ToDoTask(id: '2', name: 'doing homework', status: ToDoTaskStatus.notYet),
    ];
    blocTest('Should emit ToDoTaskList into ToDoLoaded',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) async {
          when(getToDoListUseCase(NoParams()))
              .thenAnswer((_) async => const Right(listToDoTask));
          bloc.add(GetToDoTaskListEvent());
        },
        expect: () => [GetToDoLoading(), const ToDoLoaded(list: listToDoTask)]);

    blocTest('Should emit Error',
        build: () => toDoBloc,
        act: (ToDoBloc bloc) async {
          when(getToDoListUseCase(NoParams()))
              .thenAnswer((_) async => Left(EmptyToDoFailure()));
          bloc.add(GetToDoTaskListEvent());
        },
        expect: () => [
              GetToDoLoading(),
              const GetToDoError(message: emptyToDoFailureMsg)
            ]);
  });
}
