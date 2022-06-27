import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
import 'package:to_do_app_manabie/core/utils/validate_input.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/create_to_do_task_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/get_to_do_task_list_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/update_status_to_do_use_case.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/create_to_do/create_to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/page_change/page_change_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/pages/main_page.dart';
import 'package:to_do_app_manabie/theme/custom_theme.dart';

import '../blocs/create_to_do/create_to_do_bloc_test.mocks.dart';
import '../blocs/to_do/to_do_bloc_test.mocks.dart';

void main() {
  final sl = GetIt.instance;
  late CreateToDoUseCase createToDoUseCase;
  late GetToDoListUseCase getToDoListUseCase;
  late UpdateStatusToDoUseCase updateStatusToDoUseCase;
  late ValidateInput validateInput;

  Future<void> setupDependencyInjection() async {
    createToDoUseCase = MockCreateToDoUseCase();
    getToDoListUseCase = MockGetToDoListUseCase();
    updateStatusToDoUseCase = MockUpdateStatusToDoUseCase();
    validateInput = MockValidateInput();
    sl.registerFactory<CreateToDoBloc>(() => CreateToDoBloc(
        createToDoUseCase: createToDoUseCase, validateInput: validateInput));

    sl.registerFactory<ToDoBloc>(() => ToDoBloc(
          getToDoListUseCase: getToDoListUseCase,
          updateStatusToDoUseCase: updateStatusToDoUseCase,
        ));
    sl.registerFactory<PageChangeBloc>(() => PageChangeBloc());
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.theme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<ToDoBloc>()),
          BlocProvider(create: (_) => sl<PageChangeBloc>()),
          BlocProvider(create: (_) => sl<CreateToDoBloc>()),
        ],
        child: const MainPage(),
      ),
    );
  }

  tearDown(() {
    sl.reset();
  });

  const listToDoTask = [
    ToDoTask(id: '1', name: 'coding', status: ToDoTaskStatus.complete),
    ToDoTask(
        id: '2', name: 'doing homework', status: ToDoTaskStatus.incomplete),
  ];

  Future<void> arrangeGetListToDoTask() async {
    when(getToDoListUseCase(NoParams()))
        .thenAnswer((realInvocation) async => const Right(listToDoTask));
  }

  setUp(() async {
    await setupDependencyInjection();
    await arrangeGetListToDoTask();
  });

  testWidgets('Should go to page with all to do when start app',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('All'),
        findsNWidgets(2)); // one for title one for bottom navigation
  });

  testWidgets('all to do are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    for (final todo in listToDoTask) {
      expect(find.text(todo.name), findsOneWidget);
    }
  });
  const inputString = 'cleaning house';
  const newToDo =
      ToDoTask(id: '3', name: inputString, status: ToDoTaskStatus.incomplete);
  testWidgets('Should display new to do after CreateToDoTask',
      (WidgetTester tester) async {
    when(validateInput.validateName(inputString))
        .thenAnswer((_) => const Right(inputString));
    when(createToDoUseCase(const CreateToDoUseCaseParam(name: inputString)))
        .thenAnswer((_) async => const Right(newToDo));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    await tester.tap(find.text('Add'));
    await tester.pump();

    await tester.enterText(find.byType(TextFormField), inputString);
    await tester.tap(find.text('Submit'));

    expect(find.text('coding'), findsOneWidget);
    expect(find.text('doing homework'), findsOneWidget);
    expect(find.text(inputString), findsOneWidget);
  });
}
