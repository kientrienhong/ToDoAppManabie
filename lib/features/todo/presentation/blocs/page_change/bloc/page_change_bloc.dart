import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_change_event.dart';
part 'page_change_state.dart';

class PageChangeBloc extends Bloc<PageChangeEvent, PageChangeState> {
  PageChangeBloc() : super(const PageChangeState(index: 0)) {
    on<PageChangeEvent>((event, emit) {
      emit(PageChangeState(index: event.index));
    });
  }
}
