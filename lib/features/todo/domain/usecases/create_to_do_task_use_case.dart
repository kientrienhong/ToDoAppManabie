import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
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

class CreateToDoUseCaseParam extends Equatable {
  final String name;
  const CreateToDoUseCaseParam({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}
