part of 'page_change_bloc.dart';

class PageChangeEvent extends Equatable {
  final int index;
  const PageChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}
