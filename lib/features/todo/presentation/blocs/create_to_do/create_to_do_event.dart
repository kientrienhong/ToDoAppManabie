part of 'create_to_do_bloc.dart';

class CreateToDoEvent extends Equatable {
  final String name;
  const CreateToDoEvent(
    this.name,
  );

  @override
  List<Object> get props => [name];
}
