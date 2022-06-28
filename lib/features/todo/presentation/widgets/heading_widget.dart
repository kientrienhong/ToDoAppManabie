import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/create_to_do/create_to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/to_do/to_do_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/widgets/alert_widget.dart';
import 'package:to_do_app_manabie/injection_container.dart';

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
                    onPressAdd(context);
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
      ],
    );
  }

  void onPressAdd(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<CreateToDoBloc>()),
                BlocProvider.value(value: BlocProvider.of<ToDoBloc>(context)),
              ],
              child: const AlertWidget(),
            ));
  }
}
