part of 'to_do_bloc.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();

  @override
  List<Object> get props => [];
}

class ToDoInitial extends ToDoState {}

class GetToDoLoading extends ToDoState {}

class ToDoLoaded extends ToDoState {
  final List<ToDoTask> list;
  const ToDoLoaded({
    required this.list,
  });
}

class GetToDoError extends ToDoState {
  final String message;
  const GetToDoError({
    required this.message,
  });
}

class CreateToDoLoading extends ToDoState {}

class CreateToDoLoaded extends ToDoState {}

class CreateToDoError extends ToDoState {
  final String message;
  const CreateToDoError({
    required this.message,
  });
}

class UpdateToDoError extends ToDoState {}

class UpdateLoading extends ToDoState {}
