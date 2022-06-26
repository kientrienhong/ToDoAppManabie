import 'dart:convert';

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

  ToDoTaskModel copyWith({String? id, String? name, ToDoTaskStatus? status}) {
    return ToDoTaskModel(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, "name": name, 'status': status.index};
  }

  static String fromListToJson(List<ToDoTaskModel> toDoModelList) =>
      jsonEncode(toDoModelList.map((e) => e.toMap()).toList());

  static List<ToDoTaskModel> fromJsonToList(List<dynamic> listMap) =>
      listMap.map((e) => ToDoTaskModel.fromJson(e)).toList();
}
