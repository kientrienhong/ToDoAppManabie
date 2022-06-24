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

  group('createToDoTask', () {
    const name = 'coding';

    const ToDoTaskModel toDoTaskModel =
        ToDoTaskModel(id: '1', name: name, status: ToDoTaskStatus.notYet);
    const ToDoTask toDoTask = toDoTaskModel;
    test('Should return ToDoModel when create successfully', () async {
      when(toDoTaskLocalDataSource.createToDoTask(name))
          .thenAnswer((_) async => toDoTaskModel);

      final response = await toDoRepositoryImpl.createToDoTask(name);

      verify(toDoTaskLocalDataSource.createToDoTask(name));

      expect(response, equals(const Right(toDoTask)));
    });

    test('Should return UnexpectedFailure when get unexpecting exception',
        () async {
      when(toDoTaskLocalDataSource.createToDoTask(name))
          .thenThrow(UnexpectedException(message: 'Unexpected Message'));

      final response = await toDoRepositoryImpl.createToDoTask(name);

      verify(toDoTaskLocalDataSource.createToDoTask(name));
      expect(response, equals(Left(UnexpectedFailure())));
    });

    test('Should return ExistedNameFailure when get existed name exception',
        () async {
      when(toDoTaskLocalDataSource.createToDoTask(name))
          .thenThrow(ExistedNameException());

      final response = await toDoRepositoryImpl.createToDoTask(name);

      verify(toDoTaskLocalDataSource.createToDoTask(name));
      expect(response, equals(Left(ExistedNameFailure())));
    });
    test('Should return LocalFailure when get local exception', () async {
      when(toDoTaskLocalDataSource.createToDoTask(name))
          .thenThrow(LocalException());

      final response = await toDoRepositoryImpl.createToDoTask(name);

      verify(toDoTaskLocalDataSource.createToDoTask(name));
      expect(response, equals(Left(LocalFailure())));
    });
  });

  group('getToDoTaskList', () {
    const List<ToDoTaskModel> listModel = [
      ToDoTaskModel(id: '1', name: 'coding', status: ToDoTaskStatus.done),
      ToDoTaskModel(
          id: '2', name: 'doing homework', status: ToDoTaskStatus.notYet),
      ToDoTaskModel(
          id: '3', name: 'cleaning house', status: ToDoTaskStatus.notYet),
    ];
    const List<ToDoTask> listEntity = listModel;
    test('Should return ToDoTaskList when calling success', () async {
      when(toDoTaskLocalDataSource.getToDoTaskList())
          .thenAnswer((_) async => listModel);

      final response = await toDoRepositoryImpl.getListToDoTasks();
      verify(toDoTaskLocalDataSource.getToDoTaskList());
      expect(response, equals(const Right(listEntity)));
    });

    test('Should return EmptyToDoFailure when do not have any to do', () async {
      when(toDoTaskLocalDataSource.getToDoTaskList())
          .thenThrow(EmptyToDoException());

      final response = await toDoRepositoryImpl.getListToDoTasks();
      verify(toDoTaskLocalDataSource.getToDoTaskList());
      expect(response, equals(Left(EmptyToDoFailure())));
    });
  });

  group('updateToDoTask', () {
    const id = '1';
    const ToDoTaskModel toDoTaskModel =
        ToDoTaskModel(id: id, name: 'coding', status: ToDoTaskStatus.notYet);
    const ToDoTask toDoTask = toDoTaskModel;
    test('Should return ToDoModel when update successfully', () async {
      when(toDoTaskLocalDataSource.updateToDoTask(id))
          .thenAnswer((_) async => toDoTaskModel);

      final response = await toDoRepositoryImpl.updateToDoTask(id);

      verify(toDoTaskLocalDataSource.updateToDoTask(id));

      expect(response, equals(const Right(toDoTask)));
    });

    test('Should return LocalFailure when get local exception', () async {
      when(toDoTaskLocalDataSource.updateToDoTask(id))
          .thenThrow(LocalException());

      final response = await toDoRepositoryImpl.updateToDoTask(id);

      verify(toDoTaskLocalDataSource.updateToDoTask(id));
      expect(response, equals(Left(LocalFailure())));
    });

    test('Should return UnexpectedFailure when get unexpecting exception',
        () async {
      when(toDoTaskLocalDataSource.updateToDoTask(id))
          .thenThrow(UnexpectedException(message: 'Unexpected Message'));

      final response = await toDoRepositoryImpl.updateToDoTask(id);

      verify(toDoTaskLocalDataSource.updateToDoTask(id));
      expect(response, equals(Left(UnexpectedFailure())));
    });
  });
}
