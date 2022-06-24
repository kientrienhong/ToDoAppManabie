import 'package:equatable/equatable.dart';

class ToDoTask extends Equatable {
  final String id;
  final String name;
  final bool isCheck;
  const ToDoTask({
    required this.id,
    required this.name,
    required this.isCheck,
  });

  @override
  List<Object?> get props => [id];
}
