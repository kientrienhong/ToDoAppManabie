import 'package:equatable/equatable.dart';

enum ToDoTaskStatus { notYet, done }

class ToDoTask extends Equatable {
  final String id;
  final String name;
  final ToDoTaskStatus status;
  const ToDoTask({
    required this.id,
    required this.name,
    required this.status,
  });

  @override
  List<Object?> get props => [id];
}
