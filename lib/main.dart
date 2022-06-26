import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/page_change/page_change_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/create_to_do/create_to_do_bloc.dart';

import 'package:to_do_app_manabie/features/todo/presentation/pages/main_page.dart';
import 'package:to_do_app_manabie/theme/custom_theme.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.theme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<ToDoBloc>()),
          BlocProvider(create: (_) => di.sl<PageChangeBloc>()),
          BlocProvider(create: (_) => di.sl<CreateToDoBloc>()),
        ],
        child: const MainPage(),
      ),
    );
  }
}
