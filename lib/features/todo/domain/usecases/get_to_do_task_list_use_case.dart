import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';

class GetToDoListUseCase extends UseCase<List<ToDoTask>, NoParams> {
  final ToDoTaskRepository toDoRepository;
  GetToDoListUseCase({
    required this.toDoRepository,
  });

  @override
  Future<Either<Failure, List<ToDoTask>>> call(NoParams params) async {
    return await toDoRepository.getListToDoTasks();
  }
}
