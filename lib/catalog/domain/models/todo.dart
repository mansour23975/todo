import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? todoText;
  @HiveField(2)
  bool? completed;
  @HiveField(3)
  int? userID;

  ToDo({
     this.id,
     this.todoText,
    this.completed = false,
    this.userID
  });

  static List<ToDo> todoList() {
    return [

    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userID,
      'id': id,
      'todo': todoText,
      'completed': completed,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id : map['id'] != null ? map['id'] as int : null,
      todoText : map['todo'] != null ? map['todo'] as String : null,
      completed :  map['completed'] != null ? map['completed'] as bool : null,
      userID: map['userId'] != null ? map['userId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(source) =>
      ToDo.fromMap(source as Map<String, dynamic>);

}