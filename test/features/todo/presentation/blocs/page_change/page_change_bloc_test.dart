import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app_manabie/features/todo/presentation/blocs/page_change/page_change_bloc.dart';

void main() {
  late final PageChangeBloc bloc;

  setUp(() {
    bloc = PageChangeBloc();
  });
  int pageChange = 1;

  test('Index should be 0 when initial state', () {
    expect(bloc.state, equals(const PageChangeState(index: 0)));
  });

  blocTest('Should emit PageChangeLoaded with appropriate',
      build: () => bloc,
      act: (PageChangeBloc bloc) =>
          bloc.add(PageChangeEvent(index: pageChange)),
      expect: () => [PageChangeState(index: pageChange)]);
}
