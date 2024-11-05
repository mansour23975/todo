import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_app/catalog/domain/models/todo.dart';
import 'package:todo_flutter_app/catalog/domain/remote/todo/responses/todos_response.dart';
import 'package:todo_flutter_app/catalog/enums/request_state.dart';
import 'package:todo_flutter_app/catalog/infrastructure/repository/todo/todo_repository.dart';
import '../../../../common/config/shared_data.dart';
import '../../../domain/remote/common/response_type.dart';
import '../../../domain/remote/common/response_wrapper.dart';
import 'home_event.dart';
import 'home_state.dart';



class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodosRepository todosRepository;

  HomeBloc({required this.todosRepository}) : super(HomeState()) {
    on<GetTodosList>(_getTodosList);
  }

  _getTodosList(GetTodosList event, Emitter<HomeState> emit) async {

    if (SharedData.shared.isGuest()) {
      emit(state.copyWith(
        requestState: RequestState.isGuest,
      ));
      return;
    }
    /*if ((state.skip + state.limit) > state.total) {
      return;
    }*/

    //if already loading, return
    if (state.requestState == RequestState.loading || state.requestState == RequestState.nextPageLoading) {
      return;
    }

    emit(state.copyWith(
      requestState: state.skip == 0 ? RequestState.loading : RequestState.nextPageLoading,
    ));
    try {
      ResponseWrapper<TodosResponse?> response = await todosRepository.getTodosList(limit: state.limit,skip: state.skip);
      switch (response.responseType) {
        case ResponseType.success:
          List<ToDo>? todosList = state.skip == 0
              ? response.data?.todosList?.data
              : [...?state.todos, ...?response.data?.todosList?.data];
          await todosRepository.saveTodosLocally(todos: todosList ?? []);
          //final localTodos = await todosRepository.fetchAllLocalToDos();
          state.skip = (response.data?.todosList?.meta?.skip ?? 0) + (response.data?.todosList?.meta?.limit ?? 10);
          emit(state.copyWith(
            requestState: state.skip == 0 ? RequestState.loaded : RequestState.nextPageLoaded,
            todos: todosList,
          ));
          break;
        default:
          emit(state.copyWith(
              requestState: state.skip == 0 ? RequestState.failed : RequestState.nextPageFailed,
              errorMessage: response.message));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          requestState: state.skip == 0 ? RequestState.failed : RequestState.nextPageFailed,
          errorMessage: 'general_error'));
    }
  }
}
