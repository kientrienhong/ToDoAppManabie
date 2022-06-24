import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_manabie/core/exception/exception.dart';
import 'package:to_do_app_manabie/features/todo/data/models/to_do_task_model.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';

abstract class ToDoTaskLocalDataSource {
  Future<List<ToDoTaskModel>> getToDoTaskList();
  Future<ToDoTaskModel> createToDo(String name);
}

class ToDoTaskLocalDataSourceSharedPreference
    implements ToDoTaskLocalDataSource {
  SharedPreferences sharedPreferences;

  ToDoTaskLocalDataSourceSharedPreference({required this.sharedPreferences});

  bool _findExistedName(String name, List<ToDoTaskModel> list) {
    for (ToDoTaskModel model in list) {
      if (model.name == name) {
        return true;
      }
    }
    return false;
  }

  Future<void> _checkSetString(List<ToDoTaskModel> list) async {
    bool result = await sharedPreferences.setString(
        'todos', ToDoTaskModel.fromListToJson(list));
    if (!result) {
      throw LocalException();
    }
  }

  @override
  Future<ToDoTaskModel> createToDo(String name) async {
    final json = sharedPreferences.getString('todos');
    ToDoTaskModel model;
    if (json != null) {
      final listMap = jsonDecode(json) as List<dynamic>;
      final listToDoTaskModel = ToDoTaskModel.fromJsonToList(listMap);
      bool isExistedName = _findExistedName(name, listToDoTaskModel);
      if (isExistedName) {
        throw ExistedNameException();
      } else {
        String id = listToDoTaskModel[listToDoTaskModel.length - 1].id;
        int newId = int.parse(id) + 1;
        model = ToDoTaskModel(
            id: newId.toString(), name: name, status: ToDoTaskStatus.notYet);
        listToDoTaskModel.add(model);
        await _checkSetString(listToDoTaskModel);
      }
    } else {
      model = ToDoTaskModel(id: '1', name: name, status: ToDoTaskStatus.notYet);
      await _checkSetString([model]);
    }

    return model;
  }

  @override
  Future<List<ToDoTaskModel>> getToDoTaskList() {
    throw UnimplementedError();
  }
}
