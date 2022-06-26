import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class CompleteToDoPage extends StatefulWidget {
  const CompleteToDoPage({super.key});

  @override
  State<CompleteToDoPage> createState() => _CompleteToDoPageState();
}

class _CompleteToDoPageState extends State<CompleteToDoPage> {
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
                subtitle: 'Complete',
              ),
              ToDoList(currentPage: 1),
            ],
          ),
        ),
      ),
    );
  }
}
