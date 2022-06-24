import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:to_do_app_manabie/features/todo/data/datasources/to_do_task_local_data_source.dart';
import 'package:to_do_app_manabie/features/todo/data/repositories/to_do_task_repository_impl.dart';

import 'to_do_repository_impl.mocks.dart';

@GenerateMocks([ToDoTaskLocalDataSource])
void main() {
  // late ToDoTaskLocalDataSource toDoTaskLocalDataSource;
  // late ToDoTaskRepositoryImpl toDoRepositoryImpl;

  // setUp(() {
  //   toDoLocalDataSource = MockToDoLocalDataSource();
  //   toDoRepositoryImpl =
  //       ToDoTaskRepositoryImpl(toDoTaskLocalDataSource: toDoLocalDataSource);
  // });

  // group('createToDo', () {});
}
