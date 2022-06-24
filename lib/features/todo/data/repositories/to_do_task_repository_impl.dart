import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/exception/exception.dart';

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
  Future<Either<Failure, List<ToDoTask>>> getListToDoTasks() async {
    try {
      final response = await toDoTaskLocalDataSource.getToDoTaskList();
      return Right(response);
    } on EmptyToDoException {
      return Left(EmptyToDoFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, ToDoTask>> createToDoTask(String name) async {
    try {
      final response = await toDoTaskLocalDataSource.createToDoTask(name);
      return Right(response);
    } on UnexpectedException {
      return Left(UnexpectedFailure());
    } on ExistedNameException {
      return Left(ExistedNameFailure());
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, ToDoTask>> updateToDoTask(String id) async {
    try {
      final response = await toDoTaskLocalDataSource.updateToDoTask(id);
      return Right(response);
    } on UnexpectedException {
      return Left(UnexpectedFailure());
    } on LocalException {
      return Left(LocalFailure());
    }
  }
}
