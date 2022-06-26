import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/utils/validate_input.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/create_to_do_task_use_case.dart';

part 'create_to_do_event.dart';
part 'create_to_do_state.dart';

const expectedFailureMsg = "Unexpected Error";
const existedNameFailureMsg = 'Existed name! Please provide another one';
const localDataSourceFailureMsg = 'Memory storage having problem';
const emptyNameFailureMsg = 'Please provide name';

class CreateToDoBloc extends Bloc<CreateToDoEvent, CreateToDoState> {
  final CreateToDoUseCase createToDoUseCase;
  final ValidateInput validateInput;
  CreateToDoBloc({required this.createToDoUseCase, required this.validateInput})
      : super(CreateToDoInitial()) {
    on<CreateToDoEvent>((event, emit) async {
      emit(CreateToDoLoading());

      final response =
          await createToDoUseCase(CreateToDoUseCaseParam(name: event.name));

      response.fold(
          (l) => emit(CreateToDoError(error: _mapFailureToMessage(l))),
          (r) => emit(CreateToDoLoaded(task: r)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case EmptyNameFailure:
        return emptyNameFailureMsg;

      case ExistedNameFailure:
        return existedNameFailureMsg;

      case LocalFailure:
        return localDataSourceFailureMsg;

      default:
        return expectedFailureMsg;
    }
  }
}
