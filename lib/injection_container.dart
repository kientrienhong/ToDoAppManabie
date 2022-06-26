import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_manabie/core/utils/validate_input.dart';
import 'package:to_do_app_manabie/features/todo/data/datasources/to_do_task_local_data_source.dart';
import 'package:to_do_app_manabie/features/todo/data/repositories/to_do_task_repository_impl.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_task_repository.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/create_to_do_task_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/get_to_do_task_list_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/update_status_to_do_use_case.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/create_to_do/create_to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/page_change/bloc/page_change_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ToDoBloc(
        getToDoListUseCase: sl(),
        updateStatusToDoUseCase: sl(),
      ));
  sl.registerFactory(() => PageChangeBloc());
  sl.registerFactory(
      () => CreateToDoBloc(createToDoUseCase: sl(), validateInput: sl()));
  // use cases
  sl.registerLazySingleton(() => GetToDoListUseCase(toDoRepository: sl()));
  sl.registerLazySingleton(() => CreateToDoUseCase(toDoRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateStatusToDoUseCase(toDoTaskRepository: sl()));

  // Respotitory
  sl.registerLazySingleton<ToDoTaskRepository>(
      () => ToDoTaskRepositoryImpl(toDoTaskLocalDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ToDoTaskLocalDataSource>(
    () => ToDoTaskLocalDataSourceSharedPreference(sharedPreferences: sl()),
  );
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //core
  sl.registerLazySingleton(() => ValidateInput());
}
