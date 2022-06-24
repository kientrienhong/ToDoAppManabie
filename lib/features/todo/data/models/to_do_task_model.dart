import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';

class ToDoTaskModel extends ToDoTask {
  const ToDoTaskModel(
      {required super.id, required super.name, required super.status});

  factory ToDoTaskModel.fromJson(Map<String, dynamic> json) {
    return ToDoTaskModel(
        id: json['id'],
        name: json['name'],
        status: ToDoTaskStatus.values[json['status']]);
  }
}
