import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/page_change/page_change_bloc.dart';
import 'package:to_do_app_manabie/features/todo/presentation/pages/all_to_do_page.dart';
import 'package:to_do_app_manabie/features/todo/presentation/pages/complete_to_do_page.dart';
import 'package:to_do_app_manabie/features/todo/presentation/pages/incomplete_to_do_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> listScreen = const [
    AllToDoPage(),
    CompleteToDoPage(),
    IncompleteToDoPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PageChangeBloc, PageChangeState>(
        builder: (context, state) {
          return listScreen[state.index];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapChangeScreen,
          currentIndex: BlocProvider.of<PageChangeBloc>(context, listen: true)
              .state
              .index,
          items: const [
            BottomNavigationBarItem(
                label: 'All',
                icon: ImageIcon(
                  AssetImage("assets/imgs/all.png"),
                  color: Color(0xFF3A5A98),
                )),
            BottomNavigationBarItem(
                label: 'Complete',
                icon: ImageIcon(
                  AssetImage("assets/imgs/complete.png"),
                  color: Color(0xFF3A5A98),
                )),
            BottomNavigationBarItem(
                label: 'Incomplete',
                icon: ImageIcon(
                  AssetImage("assets/imgs/incomplete.png"),
                  color: Color(0xFF3A5A98),
                ))
          ]),
    );
  }

  void onTapChangeScreen(int index) {
    final bloc = BlocProvider.of<PageChangeBloc>(context);
    bloc.add(PageChangeEvent(index: index));
  }
}
