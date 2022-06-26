part of 'to_do_bloc.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object> get props => [];
}

class GetToDoTaskListEvent extends ToDoEvent {}

class AddToDoTask extends ToDoEvent {
  final ToDoTask toDoTask;
  const AddToDoTask({required this.toDoTask});
}

class UpdateToDoTaskEvent extends ToDoEvent {
  final String id;
  const UpdateToDoTaskEvent({
    required this.id,
  });
}
