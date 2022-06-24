import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/create_to_do_task_use_case.dart';

import 'get_to_do_list_use_case_test.mocks.dart';

void main() {
  // late CreateToDoUseCase useCase;
  // late ToDoTaskRepository toDoRepository;

  // setUp(() {
  //   toDoRepository = MockToDoRepository();
  //   useCase = CreateToDoUseCase(toDoRepository: toDoRepository);
  // });

  // group('createToDo', () {
  //   const name = 'coding';
  //   test('Should return Unit when create successfully', () async {
  //     when(toDoRepository.createToDoTask(name))
  //         .thenAnswer((_) async => const Right(unit));

  //     final response = await useCase(name);

  //     verify(toDoRepository.createToDoTask(name));

  //     expect(response, equals(const Right(unit)));
  //   });

  //   test(
  //       'Should return UnexptedFailure when create fail with an unexpecting exception',
  //       () async {
  //     when(toDoRepository.createToDoTask(name))
  //         .thenAnswer((_) async => Left(UnexpectedFailure()));

  //     final response = await useCase(name);

  //     verify(toDoRepository.createToDoTask(name));

  //     expect(response, equals(Left(UnexpectedFailure())));
  //   });
  // });
}
