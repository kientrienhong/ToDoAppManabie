import 'package:equatable/equatable.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';

class UpdateStatusToDoUseCase
    extends UseCase<ToDoTask, UpdateStatusToDoParams> {
  final ToDoTaskRepository toDoTaskRepository;

  UpdateStatusToDoUseCase({required this.toDoTaskRepository});

  @override
  Future<Either<Failure, ToDoTask>> call(UpdateStatusToDoParams params) async {
    return await toDoTaskRepository.updateToDoTask(params.id);
  }
}

class UpdateStatusToDoParams extends Equatable {
  final String id;
  const UpdateStatusToDoParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
