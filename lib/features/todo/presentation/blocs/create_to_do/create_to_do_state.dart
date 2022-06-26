part of 'create_to_do_bloc.dart';

abstract class CreateToDoState extends Equatable {
  const CreateToDoState();

  @override
  List<Object> get props => [];
}

class CreateToDoInitial extends CreateToDoState {}

class CreateToDoLoaded extends CreateToDoState {
  final ToDoTask task;
  const CreateToDoLoaded({
    required this.task,
  });
}

class CreateToDoLoading extends CreateToDoState {}

class CreateToDoError extends CreateToDoState {
  final String error;
  const CreateToDoError({
    required this.error,
  });
}
