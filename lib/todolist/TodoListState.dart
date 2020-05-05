import 'package:error_proof_demo/model/Todo.dart';
import 'package:error_proof_demo/state_management/Navigational.dart';
import '../state_management/State.dart';

class TodoListState extends State {
  List<Todo> todoItems = List();
  bool isAdding = false;

  TodoListState(): super();

  TodoListState.create({this.todoItems, this.isAdding = false, bool isNavigational = false, NavigationMethod navigationMethod, String navigationPath}):
        super(isNavigational: isNavigational, navigationMethod: navigationMethod, navigationPath: navigationPath);


  TodoListState copyWith({List<Todo> todoItems, bool isAdding,  bool isNavigational, NavigationMethod navigationMethod, String navigationPath}) {
    TodoListState newState =  TodoListState();

    if (todoItems != null) {
      newState.todoItems = todoItems;
    } else {
      newState.todoItems = this.todoItems;
    }

    if (isAdding != null) {
      newState.isAdding = isAdding;
    }

    if (isNavigational != null) {
      newState.isNavigational = isNavigational;
    }

    if (navigationMethod != null) {
      newState.navigationMethod = navigationMethod;
    }

    if (navigationPath != null) {
      newState.navigationPath = navigationPath;
    }

    return newState;
  }
}

