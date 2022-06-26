import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class AllToDoPage extends StatefulWidget {
  const AllToDoPage({super.key});

  @override
  State<AllToDoPage> createState() => _AllToDoPageState();
}

class _AllToDoPageState extends State<AllToDoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: const [
              HeadingWidget(title: 'To Do List', subtitle: 'All'),
              ToDoList(
                currentPage: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
