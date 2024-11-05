import 'package:dio/dio.dart';
import 'package:todo_flutter_app/catalog/domain/models/todo.dart';
import 'package:todo_flutter_app/common/config/api_urls.dart';

class TodosRemoteDataSource {

  TodosRemoteDataSource(this.dio);

  final Dio dio;


  Future<dynamic> getTodosList({required int limit, required int skip}) async {
    try{
      Response response = await dio.get(APIUrls.todosList, queryParameters: {"limit": limit, "skip": skip});
      return response;
    }
    catch(e){
      print(e);
    }

  }


  Future<dynamic> deleteTodo({required int id}) async {
    try{
      Response response = await dio.delete(APIUrls.delete+"/$id");
      return response;
    }
    catch(e){
      print(e);
    }

  }
  Future<dynamic> addTodo({required ToDo model}) async {
    try{
      Response response = await dio.post(APIUrls.add, data: model.toJson());
      return response;
    }
    catch(e){
      print(e);
    }

  }

}