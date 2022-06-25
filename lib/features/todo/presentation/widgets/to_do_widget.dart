import 'package:flutter/material.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';

class ToDoWidget extends StatelessWidget {
  final ToDoTask toDo;
  const ToDoWidget({super.key, required this.toDo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
                value: toDo.status == ToDoTaskStatus.complete,
                onChanged: (val) => {}),
            Text(
              toDo.name,
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ],
    );
  }
}
