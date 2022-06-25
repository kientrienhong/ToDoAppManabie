part of 'page_change_bloc.dart';

class PageChangeState extends Equatable {
  final int index;
  const PageChangeState({required this.index});

  @override
  List<Object?> get props => [index];
}
