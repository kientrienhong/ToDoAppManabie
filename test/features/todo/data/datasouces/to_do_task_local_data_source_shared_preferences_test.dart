import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_manabie/features/todo/data/datasources/to_do_task_local_data_source.dart';

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
    // test('Should return ', body)
  });
}
