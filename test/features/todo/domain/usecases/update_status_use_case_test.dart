import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/update_status_to_do_use_case.dart';

import 'get_to_do_list_use_case_test.mocks.dart';

void main() {
  late UpdateStatusToDoUseCase useCase;
  late ToDoTaskRepository toDoTaskRepository;

  setUp(() {
    toDoTaskRepository = MockToDoTaskRepository();
    useCase = UpdateStatusToDoUseCase(toDoTaskRepository: toDoTaskRepository);
  });

  group('updateToDo', () {
    const id = '1';
    const name = 'coding';
    const ToDoTask toDoTask =
        ToDoTask(id: '1', name: name, status: ToDoTaskStatus.incomplete);
    test('Should return ToDoTask when update successfully', () async {
      when(toDoTaskRepository.updateToDoTask(id))
          .thenAnswer((_) async => const Right(toDoTask));

      final response = await useCase(UpdateStatusToDoParams(id: id));

      verify(toDoTaskRepository.updateToDoTask(id));

      expect(response, equals(const Right(toDoTask)));
    });

    test(
        'Should return UnexptedFailure when create fail with an unexpecting exception',
        () async {
      when(toDoTaskRepository.updateToDoTask(id))
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      final response = await useCase(UpdateStatusToDoParams(id: id));

      verify(toDoTaskRepository.updateToDoTask(id));

      expect(response, equals(Left(UnexpectedFailure())));
    });
  });
}
