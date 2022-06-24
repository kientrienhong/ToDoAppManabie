import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/create_to_do_task_use_case.dart';

import 'get_to_do_list_use_case_test.mocks.dart';

void main() {
  late CreateToDoUseCase useCase;
  late ToDoTaskRepository toDoRepository;

  setUp(() {
    toDoRepository = MockToDoTaskRepository();
    useCase = CreateToDoUseCase(toDoRepository: toDoRepository);
  });

  group('createToDo', () {
    const name = 'coding';
    const ToDoTask toDoTask =
        ToDoTask(id: '1', name: name, status: ToDoTaskStatus.notYet);
    test('Should return Unit when create successfully', () async {
      when(toDoRepository.createToDoTask(name))
          .thenAnswer((_) async => const Right(toDoTask));

      final response = await useCase(CreateToDoUseCaseParam(name: name));

      verify(toDoRepository.createToDoTask(name));

      expect(response, equals(const Right(toDoTask)));
    });

    test(
        'Should return UnexptedFailure when create fail with an unexpecting exception',
        () async {
      when(toDoRepository.createToDoTask(name))
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      final response = await useCase(CreateToDoUseCaseParam(name: name));

      verify(toDoRepository.createToDoTask(name));

      expect(response, equals(Left(UnexpectedFailure())));
    });
  });
}
