import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/get_to_do_task_list_use_case.dart';

import 'get_to_do_list_use_case_test.mocks.dart';

@GenerateMocks([ToDoTaskRepository])
void main() {
  late ToDoTaskRepository toDoRepository;
  late GetToDoListUseCase getToDoListUseCase;

  setUp(() {
    toDoRepository = MockToDoTaskRepository();
    getToDoListUseCase = GetToDoListUseCase(toDoRepository: toDoRepository);
  });
  group('getListToDo', () {
    List<ToDoTask> list = const [
      ToDoTask(id: '1', name: 'coding', status: ToDoTaskStatus.complete),
      ToDoTask(
          id: '2', name: 'doing homework', status: ToDoTaskStatus.incomplete),
      ToDoTask(
          id: '3', name: 'cleaning room', status: ToDoTaskStatus.incomplete),
    ];

    test('Should return ListToDo when calling success', () async {
      when(toDoRepository.getListToDoTasks())
          .thenAnswer((_) async => Right(list));

      final response = await getToDoListUseCase(NoParams());

      verify(toDoRepository.getListToDoTasks());

      expect(response, equals(Right(list)));
    });

    test(
        'Should return EmptyToDoFailure when repository returned EmptyToDoFailure',
        () async {
      when(toDoRepository.getListToDoTasks())
          .thenAnswer((_) async => Left(EmptyToDoFailure()));

      final response = await getToDoListUseCase(NoParams());

      verify(toDoRepository.getListToDoTasks());

      expect(response, equals(Left(EmptyToDoFailure())));
    });
  });
}
