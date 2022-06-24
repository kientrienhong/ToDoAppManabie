import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';

class GetToDoListUseCase {
  final ToDoTaskRepository toDoRepository;
  GetToDoListUseCase({
    required this.toDoRepository,
  });

  Future<Either<Failure, List<ToDoTask>>> call() async {
    return await toDoRepository.getListToDoTasks();
  }
}
