import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/widgets/to_do_widget.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Widget _buildSuccess(List<ToDoTask> list) {
    return Expanded(
        child: ListView.builder(
            itemBuilder: (_, index) => ToDoWidget(toDo: list[index])));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (context, state) {
        if (state.status == ToDoStateStatus.loading) {
          return const CircularProgressIndicator();
        } else if (state.status == ToDoStateStatus.success) {
          return _buildSuccess(state.list);
        }
        return Container();
      },
    );
  }
}
