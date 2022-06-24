import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/exception/exception.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/data/datasources/to_do_task_local_data_source.dart';
import 'package:to_do_app_manabie/features/todo/data/models/to_do_task_model.dart';
import 'package:to_do_app_manabie/features/todo/data/repositories/to_do_task_repository_impl.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';

import 'to_do_task_repository_impl_test.mocks.dart';

@GenerateMocks([ToDoTaskLocalDataSource])
void main() {
  late ToDoTaskLocalDataSource toDoTaskLocalDataSource;
  late ToDoTaskRepositoryImpl toDoRepositoryImpl;

  setUp(() {
    toDoTaskLocalDataSource = MockToDoTaskLocalDataSource();
    toDoRepositoryImpl = ToDoTaskRepositoryImpl(
        toDoTaskLocalDataSource: toDoTaskLocalDataSource);
  });

  group('createToDo', () {
    const name = 'coding';

    const ToDoTaskModel toDoTaskModel =
        ToDoTaskModel(id: '1', name: name, status: ToDoTaskStatus.notYet);
    const ToDoTask toDoTask = toDoTaskModel;
    test('Should return ToDoModel when create successfully', () async {
      when(toDoTaskLocalDataSource.createToDo(name))
          .thenAnswer((_) async => toDoTaskModel);

      final response = await toDoRepositoryImpl.createToDoTask(name);

      verify(toDoTaskLocalDataSource.createToDo(name));

      expect(response, equals(const Right(toDoTask)));
    });

    test('Should return UnexpectedFailure when get unexpecting exception',
        () async {
      when(toDoTaskLocalDataSource.createToDo(name))
          .thenThrow(UnexpectedException(message: 'Unexpected Message'));

      final response = await toDoRepositoryImpl.createToDoTask(name);

      verify(toDoTaskLocalDataSource.createToDo(name));
      expect(response, equals(Left(UnexpectedFailure())));
    });
  });
}
