import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:todo_flutter_app/catalog/domain/models/todo.dart';
import 'package:todo_flutter_app/catalog/domain/remote/common/response_wrapper.dart';
import 'package:todo_flutter_app/catalog/domain/remote/todo/responses/todos_response.dart';
import 'package:todo_flutter_app/catalog/infrastructure/data_source/todo/todo_remote_data_source.dart';
import 'package:todo_flutter_app/common/helper/network_connection_helper.dart';
import 'package:todo_flutter_app/catalog/domain/remote/common/response_type.dart' as res_type;
class TodosRepository {
  TodosRepository( this.todosRemoteDataSource ,{required Box<ToDo> todosBox}):_todosBox = todosBox;

  final TodosRemoteDataSource todosRemoteDataSource;
  final Box<ToDo> _todosBox;
  Future<ResponseWrapper<TodosResponse?>> getTodosList({required int limit, required int skip}) async {
    String? message = await NetworkConnectionHelper.checkNetworkConnection();
    if (message != null) {
      var res = ResponseWrapper<TodosResponse?>();
      res.message = message;
      res.responseType = res_type.ResponseType.success;
      final localTodos = await this.fetchAllLocalToDos();
      res.data = TodosResponse(todosList: TodosList(data: localTodos,meta: Meta(limit: 10,skip: 10,total: 10)));
      return res;
    }

    try {
      Response response = await todosRemoteDataSource.getTodosList(limit: limit,skip: skip);
      var res = ResponseWrapper<TodosResponse>();
      print(response.data);
      switch (response.statusCode) {
        case 200:
            res.responseType = res_type.ResponseType.success;
            res.data = TodosResponse.fromJson(response.data);
            res.message = response.data['message'];
          return res;
        case 422:
          res.message = response.data['message'];
          res.responseType = res_type.ResponseType.validationError;
          return res;
        default:
          res.responseType = res_type.ResponseType.clientError;
          return res;
      }
    } catch (e) {
      print("e");
      print(e);
      var res = ResponseWrapper<TodosResponse>();
      res.message = "server_error";
      res.responseType = res_type.ResponseType.serverError;
      return res;
    }
  }


  Future<ResponseWrapper<void>> deleteTodo({required int id}) async {
    String? message = await NetworkConnectionHelper.checkNetworkConnection();
    if (message != null) {
      var res =ResponseWrapper<void>();
      res.message = message;
      res.responseType = res_type.ResponseType.networkError;
      return res;
    }

    try {
      Response response = await todosRemoteDataSource.deleteTodo(id:id);
      var res = ResponseWrapper<void>();
      switch (response.statusCode) {
        case 200:
          res.responseType = res_type.ResponseType.success;
          res.message = response.data['message'];
          return res;

        case 422:
          res.message = response.data['message'];
          res.responseType = res_type.ResponseType.validationError;
          return res;
        default:
          res.responseType = res_type.ResponseType.clientError;
          return res;
      }
    } catch (e) {
      print(e);
      var res = ResponseWrapper<void>();
      res.message = "server_error";
      res.responseType = res_type.ResponseType.serverError;
      return res;
    }
  }


  Future<ResponseWrapper<void>> addTodo({required ToDo model}) async {
    String? message = await NetworkConnectionHelper.checkNetworkConnection();
    if (message != null) {
      var res =ResponseWrapper<void>();
      res.message = message;
      res.responseType = res_type.ResponseType.networkError;
      return res;
    }

    try {
      Response response = await todosRemoteDataSource.addTodo(model:model);
      var res = ResponseWrapper<void>();
      switch (response.statusCode) {
        case 201:
          res.responseType = res_type.ResponseType.success;
          res.message = response.data['message'];
          return res;

        case 422:
          res.message = response.data['message'];
          res.responseType = res_type.ResponseType.validationError;
          return res;
        default:
          res.responseType = res_type.ResponseType.clientError;
          return res;
      }
    } catch (e) {
      print(e);
      var res = ResponseWrapper<void>();
      res.message = "server_error";
      res.responseType = res_type.ResponseType.serverError;
      return res;
    }
  }

  Future<void> saveTodosLocally({
    required List<ToDo> todos,
  }) async {
    for (final todo in todos) {
      await _todosBox.put(todo.id, todo);
    }
  }

  Future<List<ToDo>?> fetchAllLocalToDos() async {
    final localTodos = _todosBox.values.toList();
    return localTodos;
  }
}