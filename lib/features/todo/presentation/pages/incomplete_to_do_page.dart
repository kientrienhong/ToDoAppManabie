import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app_manabie/features/todo/presentation/widgets/heading_widget.dart';

class IncompleteToDoPage extends StatefulWidget {
  const IncompleteToDoPage({super.key});

  @override
  State<IncompleteToDoPage> createState() => _IncompleteToDoPageState();
}

class _IncompleteToDoPageState extends State<IncompleteToDoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              HeadingWidget(
                title: 'To Do List',
                subtitle: 'Incomplete',
              )
            ],
          ),
        ),
      ),
    );
  }
}
