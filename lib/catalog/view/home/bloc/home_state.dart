

import 'package:todo_flutter_app/catalog/domain/models/todo.dart';
import 'package:todo_flutter_app/catalog/enums/request_state.dart';

class HomeState {
  List<ToDo>? todos;
  int limit;
  int skip;
  RequestState? requestState;
  String? errorMessage;
  int total;


  HomeState({
    this.todos,
    this.requestState = RequestState.initial,
    this.errorMessage,
    this.limit = 10,
    this.skip = 0,
    this.total = 11,
  });

  HomeState copyWith({
    List<ToDo>? todos,
    int? limit,
    int? skip,
    RequestState? requestState,
    String? errorMessage,
    int? total,
  }) =>
      HomeState(
        todos: todos ?? this.todos,
        errorMessage: errorMessage ?? this.errorMessage,
        requestState: requestState ?? this.requestState,
        limit: limit ?? this.limit,
        skip: skip ?? this.skip,
        total: total ?? this.total,
      );
}
