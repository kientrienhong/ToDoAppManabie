import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';

class HeadingWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const HeadingWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subtitle,
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              width: deviceSize.width * 1 / 3,
              child: TextButton(
                  onPressed: () {
                    onPressAdd(context, deviceSize);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).secondaryHeaderColor),
                  ),
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.button,
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Container(
              width: (deviceSize.width - 48) / 3,
              height: 2,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            Container(
              width: (deviceSize.width - 48) * 2 / 3,
              height: 2,
              color: const Color(0xFF909CA1),
            )
          ],
        )
      ],
    );
  }

  void onPressAdd(BuildContext context, Size deviceSize) {
    TextEditingController nameController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => BlocProvider(
              create: (context) => BlocProvider.of<ToDoBloc>(context),
              child: AlertDialog(
                  content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create to do',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  TextFormField(
                    controller: nameController,
                  ),
                  BlocListener<ToDoBloc, ToDoState>(
                    listener: (context, state) {
                      if (state.status == ToDoStateStatus.success) {
                        Navigator.pop(context);
                      }
                    },
                    child: BlocBuilder<ToDoBloc, ToDoState>(
                      builder: (context, state) {
                        final child = Text(
                          'Submit',
                          style: Theme.of(context).textTheme.button,
                        );

                        return buildButton(
                            child: child,
                            deviceSize: deviceSize,
                            context: context,
                            function: () {
                              addNewToDo(context, nameController.text);
                            });
                      },
                    ),
                  ),
                ],
              )),
            ));
  }

  void addNewToDo(BuildContext context, String name) {
    final bloc = BlocProvider.of<ToDoBloc>(context);
    bloc.add(CreateToDoTaskEvent(name: name));
  }

  Widget buildButton(
      {required Widget child,
      required Size deviceSize,
      required BuildContext context,
      required Function function}) {
    return Center(
      child: SizedBox(
        width: deviceSize.width * 2 / 3,
        child: TextButton(
            onPressed: () => {function()},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).secondaryHeaderColor),
            ),
            child: child),
      ),
    );
  }
}
