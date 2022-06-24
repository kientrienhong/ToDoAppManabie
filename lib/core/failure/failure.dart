import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class EmptyToDoFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnexpectedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyNameFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
