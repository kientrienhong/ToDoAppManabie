import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app_manabie/features/todo/presentation/widgets/heading_widget.dart';

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
            children: [
              HeadingWidget(
                title: 'To Do List',
                subtitle: 'Complete',
              )
            ],
          ),
        ),
      ),
    );
  }
}
