import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_app_manabie/core/failure/failure.dart';
import 'package:to_do_app_manabie/features/todo/domain/entities/to_do.dart';
import 'package:to_do_app_manabie/features/todo/domain/repositories/to_do_repository.dart';
import 'package:to_do_app_manabie/features/todo/domain/usecases/get_to_do_list_use_case.dart';

import 'get_to_do_list_use_case_test.mocks.dart';

@GenerateMocks([ToDoRepository])
void main() {
  late final ToDoRepository toDoRepository;
  late final GetToDoListUseCase getToDoListUseCase;

  setUp(() {
    toDoRepository = MockToDoRepository();
    getToDoListUseCase = GetToDoListUseCase(toDoRepository: toDoRepository);
  });
  group('getListToDo', () {
    List<ToDo> list = const [
      ToDo(id: '1', name: 'coding', isCheck: true),
      ToDo(id: '2', name: 'doing homework', isCheck: false),
      ToDo(id: '3', name: 'cleaning room', isCheck: false),
    ];

    test('Should return ListToDo', () async {
      when(toDoRepository.getListToDo()).thenAnswer((_) async => Right(list));

      final response = await getToDoListUseCase();

      verify(toDoRepository.getListToDo());

      expect(response, equals(Right(list)));
    });

    test('Should return EmptyToDoFailure', () async {
      when(toDoRepository.getListToDo())
          .thenAnswer((_) async => Left(EmptyToDoFailure()));

      final response = await getToDoListUseCase();

      verify(toDoRepository.getListToDo());

      expect(response, equals(Left(EmptyToDoFailure())));
    });
  });
}
