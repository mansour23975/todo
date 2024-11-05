import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_flutter_app/catalog/domain/models/todo.dart';
import 'package:todo_flutter_app/catalog/domain/remote/common/response_type.dart';
import 'package:todo_flutter_app/catalog/infrastructure/repository/todo/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TODOBloc extends Bloc<TODOEvent, TODOState> {
  TODOBloc({
    required this.todosRepository,
  }) : super(TODOInitial()) {
    on<DeleteTodo>(_onDeleteTodo);
    on<AddTodo>(_onAddTodo);
  }

  final TodosRepository todosRepository;

  Future<void> _onDeleteTodo(DeleteTodo event, emit) async {
    try {
      emit(DeleteTodoLoading());
      final response = await todosRepository.deleteTodo(id: event.id);
      switch (response.responseType) {
        case ResponseType.success:
          emit(DeleteTodoSuccessfully());
          break;
        default:
          emit(DeleteTodoError(response.message));
      }
    } catch (e) {
      emit(DeleteTodoError("general_error".tr()));
    }
  }

  Future<void> _onAddTodo(AddTodo event, emit) async {
    try {
      emit(AddTodoLoading());
      final response = await todosRepository.addTodo(model: event.newTodo);
      switch (response.responseType) {
        case ResponseType.success:
          emit(AddTodoSuccessfully());
          break;
        default:
          emit(AddTodoError(response.message));
      }
    } catch (e) {
      emit(AddTodoError("general_error".tr()));
    }
  }
}
