import 'dart:ffi';

import 'package:dartz/dartz.dart';

import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/data/datasources/to_do_task_local_data_source.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';

class ToDoTaskRepositoryImpl extends ToDoTaskRepository {
  final ToDoTaskLocalDataSource toDoTaskLocalDataSource;
  ToDoTaskRepositoryImpl({
    required this.toDoTaskLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ToDoTask>>> getListToDoTasks() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> createToDoTask(String name) {
    throw UnimplementedError();
  }
}
