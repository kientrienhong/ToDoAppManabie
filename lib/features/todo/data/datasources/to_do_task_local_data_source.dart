import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/features/todo/data/models/to_do_task_model.dart';

abstract class ToDoTaskLocalDataSource {
  Future<ToDoTaskModel> getToDoTaskList();
  Future<Unit> createToDo(String name);
}
