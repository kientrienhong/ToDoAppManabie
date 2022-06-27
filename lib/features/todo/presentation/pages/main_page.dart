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
          key: const Key('bottomNavigation'),
          onTap: onTapChangeScreen,
          selectedItemColor: Theme.of(context).secondaryHeaderColor,
          currentIndex: BlocProvider.of<PageChangeBloc>(context, listen: true)
              .state
              .index,
          items: [
            BottomNavigationBarItem(
                label: 'All',
                icon: ImageIcon(
                  key: const Key('bottom-all'),
                  const AssetImage("assets/imgs/all.png"),
                  color: Theme.of(context).secondaryHeaderColor,
                )),
            BottomNavigationBarItem(
                label: 'Complete',
                icon: ImageIcon(
                  key: const Key('bottom-complete'),
                  const AssetImage("assets/imgs/complete.png"),
                  color: Theme.of(context).secondaryHeaderColor,
                )),
            BottomNavigationBarItem(
                label: 'Incomplete',
                icon: ImageIcon(
                  key: const Key('bottom-incomplete'),
                  const AssetImage("assets/imgs/incomplete.png"),
                  color: Theme.of(context).secondaryHeaderColor,
                ))
          ]),
    );
  }

  void onTapChangeScreen(int index) {
    final bloc = BlocProvider.of<PageChangeBloc>(context);
    bloc.add(PageChangeEvent(index: index));
  }
}
