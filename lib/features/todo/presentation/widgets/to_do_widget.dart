import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';

class ToDoWidget extends StatelessWidget {
  final ToDoTask toDo;
  const ToDoWidget({super.key, required this.toDo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            maxLines: null,
            toDo.name,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Checkbox(
            activeColor: Theme.of(context).secondaryHeaderColor,
            value: toDo.status == ToDoTaskStatus.complete,
            onChanged: (val) => {updateStatusToDo(context, toDo.id)}),
      ],
    );
  }

  void updateStatusToDo(BuildContext context, String id) {
    BlocProvider.of<ToDoBloc>(context, listen: false)
        .add(UpdateToDoTaskEvent(id: id));
  }
}
