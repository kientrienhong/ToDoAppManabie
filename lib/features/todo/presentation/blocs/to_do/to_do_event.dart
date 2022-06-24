part of 'to_do_bloc.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object> get props => [];
}

class GetToDoTaskListEvent extends ToDoEvent {}

class CreateToDoTaskEvent extends ToDoEvent {
  final String name;
  const CreateToDoTaskEvent({
    required this.name,
  });
}

class UpdateToDoTaskEvent extends ToDoEvent {
  final String id;
  const UpdateToDoTaskEvent({
    required this.id,
  });
}
