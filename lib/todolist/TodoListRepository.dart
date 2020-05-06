import 'dart:convert';

import 'package:yatl/model/Todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TodoListRepository {
  Future<List<Todo>> getTodo();
  void save(List<Todo> todoItems);
}


class TodoListRepositoryImplementation extends TodoListRepository{
  SharedPreferences prefs;

  static const prefsTodoIdKey = "prefsTodoIdKey";

  @override
  void save(List<Todo> todoItems) {
    prefs?.setString(prefsTodoIdKey, jsonEncode(todoItems));
  }

  @override
  Future<List<Todo>> getTodo() async {

    prefs = await SharedPreferences.getInstance();
    List<Todo> todos = jsonDecode(prefs.getString(prefsTodoIdKey) ?? '[]').map<Todo>(
        (j) {
          return Todo(title: j['title'], checked: j['checked']);
        }

    ).toList();
    return todos;
  }
}