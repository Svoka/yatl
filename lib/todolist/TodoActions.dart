import 'package:yatl/model/Todo.dart';
import 'package:yatl/state_management/StateAction.dart';

abstract class TodoListAction extends StateAction {}


class ToggleAddingStateTodoAction extends TodoListAction {}

class AddTodoAction extends TodoListAction {
  Todo todo;
  AddTodoAction(this.todo);
}

class EditTodoAction extends TodoListAction {
  int todo;
  EditTodoAction(this.todo);
}

class CheckTodoAction extends TodoListAction {
  int todo;
  CheckTodoAction(this.todo);
}

class RemoveTodoAction extends TodoListAction {
  int todo;
  RemoveTodoAction(this.todo);
}