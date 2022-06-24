import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';

abstract class ToDoTaskRepository {
  Future<Either<Failure, List<ToDoTask>>> getListToDoTasks();
  Future<Either<Failure, ToDoTask>> createToDoTask(String name);
  Future<Either<Failure, ToDoTask>> updateToDoTask(String id);
}
