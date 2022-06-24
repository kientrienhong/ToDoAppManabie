import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDo>>> getListToDo();
}
