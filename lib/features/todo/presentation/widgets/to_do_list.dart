import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/widgets/to_do_widget.dart';

class ToDoList extends StatefulWidget {
  final int currentPage;
  const ToDoList({super.key, required this.currentPage});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Widget _buildSuccess(List<ToDoTask> list) {
    return Expanded(
        child: ListView.builder(
            key: PageStorageKey<String>('list to do ${widget.currentPage}'),
            padding: const EdgeInsets.all(0),
            itemCount: list.length,
            itemBuilder: (_, index) => ToDoWidget(toDo: list[index])));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ToDoBloc>(context).add(GetToDoTaskListEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<ToDoTask> _showList(List<ToDoTask> list) {
    switch (widget.currentPage) {
      case 0:
        return list;
      case 1:
        return list
            .where((element) => element.status == ToDoTaskStatus.complete)
            .toList();
      default:
        return list
            .where((element) => element.status == ToDoTaskStatus.incomplete)
            .toList();
    }
  }

  Widget _buildListSeperate(Size deviceSize) {
    return Row(
      children: [
        Container(
          width: deviceSize.width - 48,
          height: 2,
          color: const Color(0xFF909CA1),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (context, state) {
        Widget line = _buildListSeperate(deviceSize);
        Widget content = _buildSuccess(_showList(state.list));
        if (state.status == ToDoStateStatus.loading) {
          line = const LinearProgressIndicator();
        } else if (state.status == ToDoStateStatus.failure) {
          content = Center(
            child: Text(
              state.errorMsg,
              style: Theme.of(context).textTheme.headline2,
            ),
          );
        }
        return Expanded(
            child: Column(
          children: [line, content],
        ));
      },
    );
  }
}
