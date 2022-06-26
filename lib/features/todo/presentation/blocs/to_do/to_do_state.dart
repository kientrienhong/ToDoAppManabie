part of 'to_do_bloc.dart';

enum ToDoStateStatus {
  initial,
  loading,
  createLoading,
  success,
  createSuccess,
  failure
}

class ToDoState extends Equatable {
  final List<ToDoTask> list;
  final ToDoStateStatus status;
  final String errorMsg;
  const ToDoState(
      {required this.list, required this.status, required this.errorMsg});

  factory ToDoState.initial() {
    return const ToDoState(
        list: [], status: ToDoStateStatus.initial, errorMsg: '');
  }

  ToDoState copyWith({
    List<ToDoTask>? list,
    ToDoStateStatus? status,
    String? errorMsg,
  }) {
    return ToDoState(
        list: list ?? this.list,
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg);
  }

  @override
  List<Object?> get props => [list, status, errorMsg];
}

// abstract class ToDoState extends Equatable {
//   final List<ToDoTask> list;
//   const ToDoState({required this.list});

//   @override
//   List<Object> get props => [list];
// }

// class ToDoInitial extends ToDoState {}

// class GetToDoLoading extends ToDoState {}

// class ToDoLoaded extends ToDoState {
//   final List<ToDoTask> list;
//   const ToDoLoaded({
//     required this.list,
//   });
// }

// class GetToDoError extends ToDoState {
//   final String message;
//   const GetToDoError({
//     required this.message,
//   });
// }

// class CreateToDoLoading extends ToDoState {}

// class CreateToDoLoaded extends ToDoState {}

// class CreateToDoError extends ToDoState {
//   final String message;
//   const CreateToDoError({
//     required this.message,
//   });
// }

// class UpdateToDoError extends ToDoState {
//   final String message;
//   const UpdateToDoError({
//     required this.message,
//   });
// }

// class UpdateToDoLoading extends ToDoState {}
