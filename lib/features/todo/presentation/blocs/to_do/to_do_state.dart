part of 'to_do_bloc.dart';

enum ToDoStateStatus { initial, loading, success, failure }

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
