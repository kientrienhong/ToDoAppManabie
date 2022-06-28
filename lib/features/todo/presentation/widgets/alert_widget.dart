import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/create_to_do/create_to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({super.key});

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const SizedBox(
            height: 24,
            width: 24,
          ),
          Text(
            'Create to do',
            style: Theme.of(context).textTheme.headline1,
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  'assets/imgs/close.png',
                  fit: BoxFit.cover,
                )),
          )
        ]),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: nameController,
        ),
        const SizedBox(
          height: 16,
        ),
        BlocListener<CreateToDoBloc, CreateToDoState>(
          listener: (context, state) {
            if (state is CreateToDoLoaded) {
              Navigator.pop(context);
              BlocProvider.of<ToDoBloc>(context)
                  .add(AddToDoTask(toDoTask: state.task));
            }
          },
          child: BlocBuilder<CreateToDoBloc, CreateToDoState>(
            builder: (context, state) {
              Widget child = Text(
                'Submit',
                style: Theme.of(context).textTheme.button,
              );

              Widget error = Container();

              if (state is CreateToDoError) {
                error = Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).errorColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                );
              } else if (state is CreateToDoLoading) {
                child = const CircularProgressIndicator();
              }

              return Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  error,
                  const SizedBox(
                    height: 8,
                  ),
                  buildButton(
                      child: child,
                      deviceSize: deviceSize,
                      context: context,
                      function: () {
                        addNewToDo(context, nameController.text);
                      }),
                ],
              );
            },
          ),
        ),
      ],
    ));
  }

  void addNewToDo(BuildContext context, String name) {
    final bloc = BlocProvider.of<CreateToDoBloc>(context, listen: false);
    bloc.add(CreateToDoEvent(name));
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
