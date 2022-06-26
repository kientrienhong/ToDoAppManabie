import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

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
            children: const [
              HeadingWidget(
                title: 'To Do List',
                subtitle: 'Incomplete',
              ),
              ToDoList(
                currentPage: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
