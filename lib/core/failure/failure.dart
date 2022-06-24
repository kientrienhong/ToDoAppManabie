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
  List<Object?> get props => [];
}

class ExistedNameFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LocalFailure extends Failure {
  @override
  List<Object?> get props => [];
}
