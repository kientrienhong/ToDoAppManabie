import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/core/usecase/usecase.dart';
import 'package:to_do_app_manabie/core/utils/validate_input.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do_task.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/create_to_do_task_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/get_to_do_task_list_use_case.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/update_status_to_do_use_case.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

const expectedFailureMsg = "Unexpected Error";
const existedNameFailureMsg = 'Existed name! Please provide another one';
const emptyToDoFailureMsg = 'Have no to do yet!';
const localDataSourceFailureMsg = 'Memory storage having problem';
const emptyNameFailureMsg = 'Please provide name';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  GetToDoListUseCase getToDoListUseCase;
  CreateToDoUseCase createToDoUseCase;
  UpdateStatusToDoUseCase updateStatusToDoUseCase;
  ValidateInput validateInput;
  ToDoBloc(
      {required this.getToDoListUseCase,
      required this.createToDoUseCase,
      required this.updateStatusToDoUseCase,
      required this.validateInput})
      : super(ToDoState.initial()) {
    on<ToDoEvent>((event, emit) async {
      if (event is GetToDoTaskListEvent) {
        emit(state.copyWith(status: ToDoStateStatus.loading));
        final response = await getToDoListUseCase(NoParams());

        response.fold(
            (l) => emit(state.copyWith(
                errorMsg: _mapFailureToMessage(l),
                status: ToDoStateStatus.failure)),
            (r) =>
                emit(state.copyWith(list: r, status: ToDoStateStatus.success)));
      } else if (event is CreateToDoTaskEvent) {
        emit(state.copyWith(status: ToDoStateStatus.loading));
        final result = validateInput.validateName(event.name);
        result.fold(
            (l) => emit(state.copyWith(
                errorMsg: emptyNameFailureMsg,
                status: ToDoStateStatus.failure)), (r) async {
          final response =
              await createToDoUseCase(CreateToDoUseCaseParam(name: r));
          response.fold(
              (l) => emit(state.copyWith(
                  errorMsg: _mapFailureToMessage(l),
                  status: ToDoStateStatus.failure)),
              (r) => emit(state.copyWith(
                  status: ToDoStateStatus.success, list: [...state.list, r])));
        });
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case EmptyNameFailure:
        return emptyNameFailureMsg;

      case EmptyToDoFailure:
        return emptyToDoFailureMsg;

      case ExistedNameFailure:
        return existedNameFailureMsg;

      case LocalFailure:
        return localDataSourceFailureMsg;

      default:
        return expectedFailureMsg;
    }
  }
}
