import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
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
      ToDoTask(id: '1', name: 'coding', status: ToDoTaskStatus.done),
      ToDoTask(id: '2', name: 'doing homework', status: ToDoTaskStatus.notYet),
      ToDoTask(id: '3', name: 'cleaning room', status: ToDoTaskStatus.notYet),
    ];

    test('Should return ListToDo', () async {
      when(toDoRepository.getListToDoTasks())
          .thenAnswer((_) async => Right(list));

      final response = await getToDoListUseCase();

      verify(toDoRepository.getListToDoTasks());

      expect(response, equals(Right(list)));
    });

    test('Should return EmptyToDoFailure', () async {
      when(toDoRepository.getListToDoTasks())
          .thenAnswer((_) async => Left(EmptyToDoFailure()));

      final response = await getToDoListUseCase();

      verify(toDoRepository.getListToDoTasks());

      expect(response, equals(Left(EmptyToDoFailure())));
    });
  });
}
