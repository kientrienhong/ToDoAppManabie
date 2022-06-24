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
  const keyStorage = 'todos';
  setUp(() {
    sharedPreferences = MockSharedPreferences();
    toDoTaskLocalDataSourceSharedPreference =
        ToDoTaskLocalDataSourceSharedPreference(
            sharedPreferences: sharedPreferences);
  });
  List<ToDoTaskModel> arrangeReadingFromFile() {
    final json = fixture('to_do_list.json');
    final listToDo = jsonDecode(json) as List<dynamic>;
    when(sharedPreferences.getString(keyStorage)).thenAnswer((_) => json);

    return ToDoTaskModel.fromJsonToList(listToDo);
  }

  void arrangeEmptyList() {
    when(sharedPreferences.getString(keyStorage)).thenAnswer((_) => null);
  }

  group('createToDoTask', () {
    const validName = 'cleaning house';
    const validToDoTask =
        ToDoTaskModel(id: '3', name: validName, status: ToDoTaskStatus.notYet);
    const invalidName = 'coding';

    test('Should return ToDoModel when creating success', () async {
      final listToDo = arrangeReadingFromFile();
      listToDo.add(validToDoTask);
      final stringResult = ToDoTaskModel.fromListToJson(listToDo);
      when(sharedPreferences.setString(keyStorage, stringResult))
          .thenAnswer((_) async => true);

      final response = await toDoTaskLocalDataSourceSharedPreference
          .createToDoTask(validName);

      expect(response, equals(validToDoTask));
    });

    test('Should return LocalException when setString fail', () {
      final listToDo = arrangeReadingFromFile();
      listToDo.add(validToDoTask);
      final stringResult = ToDoTaskModel.fromListToJson(listToDo);
      when(sharedPreferences.setString(keyStorage, stringResult))
          .thenAnswer((_) async => false);

      final call = toDoTaskLocalDataSourceSharedPreference.createToDoTask;

      expect(
          () => call(validName), throwsA(const TypeMatcher<LocalException>()));
    });
    test('Should return ExistedNameException', () {
      arrangeReadingFromFile();
      final call = toDoTaskLocalDataSourceSharedPreference.createToDoTask;
      expect(() => call(invalidName),
          throwsA(const TypeMatcher<ExistedNameException>()));
    });
  });

  group('getToDoTaskList', () {
    test('Should return List ToDoModel', () async {
      final listToDo = arrangeReadingFromFile();
      final repsponse =
          await toDoTaskLocalDataSourceSharedPreference.getToDoTaskList();

      expect(listToDo, equals(repsponse));
    });

    test('Should return EmptyToDoException', () {
      arrangeEmptyList();
      final call = toDoTaskLocalDataSourceSharedPreference.getToDoTaskList;

      expect(() => call(), throwsA(const TypeMatcher<EmptyToDoException>()));
    });
  });

  group('updateToDoTask', () {
    const id = '1';
    const validToDoTask =
        ToDoTaskModel(id: id, name: 'coding', status: ToDoTaskStatus.notYet);
    ToDoTaskStatus notToDoTaskStatus(ToDoTaskStatus toDoTaskStatus) {
      if (toDoTaskStatus == ToDoTaskStatus.done) {
        return ToDoTaskStatus.notYet;
      }

      return ToDoTaskStatus.done;
    }

    test('Should return new Model when updating success', () async {
      final listToDo = arrangeReadingFromFile();
      int indexFound = listToDo.indexWhere((element) => element.id == id);
      ToDoTaskModel toDoTaskModelFound = listToDo[indexFound];
      listToDo[indexFound] = toDoTaskModelFound.copyWith(
          status: notToDoTaskStatus(toDoTaskModelFound.status));
      final stringResult = ToDoTaskModel.fromListToJson(listToDo);

      when(sharedPreferences.setString(keyStorage, stringResult))
          .thenAnswer((_) async => true);

      final response =
          await toDoTaskLocalDataSourceSharedPreference.updateToDoTask(id);

      expect(response, equals(validToDoTask));
    });

    test('Should return LocalException when setString fail', () {
      final listToDo = arrangeReadingFromFile();
      int indexFound = listToDo.indexWhere((element) => element.id == id);
      ToDoTaskModel toDoTaskModelFound = listToDo[indexFound];
      listToDo[indexFound] = toDoTaskModelFound.copyWith(
          status: notToDoTaskStatus(toDoTaskModelFound.status));
      final stringResult = ToDoTaskModel.fromListToJson(listToDo);
      when(sharedPreferences.setString(keyStorage, stringResult))
          .thenAnswer((_) async => false);

      final call = toDoTaskLocalDataSourceSharedPreference.updateToDoTask;

      expect(() => call(id), throwsA(const TypeMatcher<LocalException>()));
    });

    test('Should return UnexpectedException when getting empty list', () {
      arrangeEmptyList();
      final call = toDoTaskLocalDataSourceSharedPreference.updateToDoTask;

      expect(() => call(id), throwsA(const TypeMatcher<UnexpectedException>()));
    });
  });
}
