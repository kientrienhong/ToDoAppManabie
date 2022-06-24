import 'package:dartz/dartz.dart';

import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
import 'package:to_do_app_manabie/features/todo/data/models/to_do_task_model.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';

class CreateToDoUseCase extends UseCase<ToDoTask, CreateToDoUseCaseParam> {
  final ToDoTaskRepository toDoRepository;
  CreateToDoUseCase({
    required this.toDoRepository,
  });
  @override
  Future<Either<Failure, ToDoTask>> call(CreateToDoUseCaseParam params) async {
    return await toDoRepository.createToDoTask(params.name);
  }
}

class CreateToDoUseCaseParam {
  final String name;
  CreateToDoUseCaseParam({
    required this.name,
  });
}
