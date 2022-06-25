import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app_manabie/features/todo/data/models/to_do_task_model.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const ToDoTaskModel toDoModelDone =
      ToDoTaskModel(id: '1', name: 'coding', status: ToDoTaskStatus.complete);
  const ToDoTaskModel toDoModelNotYet = ToDoTaskModel(
      id: '2', name: 'doing homework', status: ToDoTaskStatus.incomplete);
  const ToDoTaskModel toDoModel = toDoModelDone;
  test('should be a subclass of ToDo', () {
    expect(toDoModel, isA<ToDoTask>());
  });
  group('fromJson', () {
    test('Should return ToDoModel with status done', () {
      final json = jsonDecode(fixture('to_do_done.json'));

      final result = ToDoTaskModel.fromJson(json);

      expect(result, equals(toDoModelDone));
    });
    test('Should return ToDoModel with status not yet', () {
      final json = jsonDecode(fixture('to_do_not_yet.json'));

      final result = ToDoTaskModel.fromJson(json);

      expect(result, equals(toDoModelNotYet));
    });
  });
}
