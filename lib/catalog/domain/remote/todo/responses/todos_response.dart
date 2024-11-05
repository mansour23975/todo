import 'package:todo_flutter_app/catalog/domain/models/todo.dart';

class TodosResponse {
  TodosList? todosList;

  TodosResponse({this.todosList,});

  TodosResponse.fromJson(Map<String, dynamic> json) {

    todosList =  new TodosList.fromJson(json);

  }

}

class TodosList {
  List<ToDo>? data;
  Meta? meta;

  TodosList({this.data, this.meta});

  TodosList.fromJson(Map<String, dynamic> json) {
    if (json['todos'] != null) {
      data = <ToDo>[];
      json['todos'].forEach((v) {
        data!.add(new ToDo.fromJson(v));
      });
    }
    meta = new Meta.fromJson(json);
  }

}



class Meta {
  int? total;
  int? skip;
  int? limit;

  Meta({this.total, this.skip, this.limit, });

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

}