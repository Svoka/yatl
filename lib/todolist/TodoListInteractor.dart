import 'package:error_proof_demo/model/Todo.dart';
import 'package:error_proof_demo/state_management/Interactor.dart';
import 'package:error_proof_demo/state_management/Reducer.dart';
import 'package:error_proof_demo/todolist/TodoActions.dart';
import 'package:error_proof_demo/todolist/TodoListRepository.dart';

import 'TodoListState.dart';

class TodoListInteractor extends Interactor<TodoListState, TodoListAction, TodoListReducer> {
  TodoListInteractor(Map<Type, TodoListReducer> reducers, TodoListState initialState, TodoListRepository repository): super(reducers, initialState) {
    repository.getTodo().then((list){
      dispatchState(TodoListState.create(todoItems: list));
    });
  }
}


abstract class TodoListReducer<T extends TodoListAction> extends Reducer<TodoListState, T> {}

class ToggleAddingStateReducer extends TodoListReducer<ToggleAddingStateTodoAction> {

  @override
  Stream<TodoListState> call(TodoListState prevState, ToggleAddingStateTodoAction action) async*{
    yield prevState.copyWith(isAdding: !prevState.isAdding);
  }
}


class AddTodoReducer extends TodoListReducer<AddTodoAction> {
  TodoListRepository repository;
  AddTodoReducer(this.repository);

  @override
  Stream<TodoListState> call(TodoListState prevState, AddTodoAction action) async* {

    List<Todo> newList = prevState.todoItems; //that is a lie
    newList.add(action.todo);
    repository.save(newList);

    yield prevState.copyWith(todoItems: newList, isAdding: false);
  }
}

class CheckTodoReducer extends TodoListReducer<CheckTodoAction> {
  TodoListRepository repository;
  CheckTodoReducer(this.repository);

  @override
  Stream<TodoListState> call(TodoListState prevState, CheckTodoAction action) async* {
    List<Todo> newList = prevState.todoItems; //that is a lie
    newList[action.todo].checked = true;
    repository.save(newList);
    yield prevState.copyWith(todoItems: newList);
  }
}

class RemoveTodoReducer extends TodoListReducer<RemoveTodoAction> {
  TodoListRepository repository;
  RemoveTodoReducer(this.repository);

  @override
  Stream<TodoListState> call(TodoListState prevState, RemoveTodoAction action) async* {
    List<Todo> newList = prevState.todoItems;
    newList.removeAt(action.todo);
    repository.save(newList);
    yield prevState.copyWith(todoItems: newList);
  }
}