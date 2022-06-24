import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_manabie/core/exception/exception.dart';
import 'package:to_do_app_manabie/features/todo/data/datasources/to_do_task_local_data_source.dart';
import 'package:to_do_app_manabie/features/todo/data/models/to_do_task_model.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'to_do_task_local_data_source_shared_preferences_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ToDoTaskLocalDataSourceSharedPreference
      toDoTaskLocalDataSourceSharedPreference;
  late SharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    toDoTaskLocalDataSourceSharedPreference =
        ToDoTaskLocalDataSourceSharedPreference(
            sharedPreferences: sharedPreferences);
  });

  group('createToDoTask', () {
    const validName = 'cleaning house';
    const validToDoTask =
        ToDoTaskModel(id: '3', name: validName, status: ToDoTaskStatus.notYet);
    const invalidName = 'coding';

    List<ToDoTaskModel> arrangeReadingFromFile() {
      final json = fixture('to_do_list.json');
      final listToDo = jsonDecode(json) as List<dynamic>;
      when(sharedPreferences.getString('todos')).thenAnswer((_) => json);

      return ToDoTaskModel.fromJsonToList(listToDo);
    }

    test('Should return ToDoModel when creating success', () async {
      final listToDo = arrangeReadingFromFile();
      listToDo.add(validToDoTask);
      final stringResult = ToDoTaskModel.fromListToJson(listToDo);
      when(sharedPreferences.setString('todos', stringResult))
          .thenAnswer((_) async => true);

      final response =
          await toDoTaskLocalDataSourceSharedPreference.createToDo(validName);

      expect(response, equals(validToDoTask));
    });

    test('Should return LocalException when setString fail', () {
      final listToDo = arrangeReadingFromFile();
      listToDo.add(validToDoTask);
      final stringResult = ToDoTaskModel.fromListToJson(listToDo);
      when(sharedPreferences.setString('todos', stringResult))
          .thenAnswer((_) async => false);
      final call = toDoTaskLocalDataSourceSharedPreference.createToDo;

      expect(
          () => call(validName), throwsA(const TypeMatcher<LocalException>()));
    });
    test('Should return ExistedNameException', () {
      arrangeReadingFromFile();
      final call = toDoTaskLocalDataSourceSharedPreference.createToDo;
      expect(() => call(invalidName),
          throwsA(const TypeMatcher<ExistedNameException>()));
    });
  });
}
