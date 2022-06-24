import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';

class CreateToDoUseCase {
  final ToDoTaskRepository toDoRepository;
  CreateToDoUseCase({
    required this.toDoRepository,
  });

  Future<Either<Failure, Unit>> call(String name) async {
    return await toDoRepository.createToDoTask(name);
  }
}
