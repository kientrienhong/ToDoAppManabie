import 'package:dartz/dartz.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_repository.dart';

class GetToDoListUseCase {
  final ToDoRepository toDoRepository;
  GetToDoListUseCase({
    required this.toDoRepository,
  });

  Future<Either<Failure, List<ToDo>>> call() async {
    return await toDoRepository.getListToDo();
  }
}
