import 'package:equatable/equatable.dart';

class ToDo extends Equatable {
  final String id;
  final String name;
  final bool isCheck;
  const ToDo({
    required this.id,
    required this.name,
    required this.isCheck,
  });

  @override
  List<Object?> get props => [id];
}
