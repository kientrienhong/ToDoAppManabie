import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class EmptyToDoFailure extends Failure {
  @override
  List<Object?> get props => [];
}
