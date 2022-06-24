import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_manabie/features/todo/data/models/to_do_task_model.dart';

abstract class ToDoTaskLocalDataSource {
  Future<List<ToDoTaskModel>> getToDoTaskList();
  Future<ToDoTaskModel> createToDo(String name);
}

class ToDoTaskLocalDataSourceSharedPreference
    implements ToDoTaskLocalDataSource {
  SharedPreferences sharedPreferences;

  ToDoTaskLocalDataSourceSharedPreference({required this.sharedPreferences});

  @override
  Future<ToDoTaskModel> createToDo(String name) {
    throw UnimplementedError();
  }

  @override
  Future<List<ToDoTaskModel>> getToDoTaskList() {
    throw UnimplementedError();
  }
}
