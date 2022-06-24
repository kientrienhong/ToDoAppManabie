import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app_manabie/features/todo/data/models/to_do_task_model.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const ToDoTaskModel toDoModel =
      ToDoTaskModel(id: '1', name: 'coding', isCheck: true);
  test('should be a subclass of ToDo', () {
    expect(toDoModel, isA<ToDoTask>());
  });
  group('fromJson', () {
    test('Should return ToDoModel', () {
      final json = jsonDecode(fixture('to_do.json'));

      final result = ToDoTaskModel.fromJson(json);

      expect(result, equals(toDoModel));
    });
  });
}
