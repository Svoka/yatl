import 'package:error_proof_demo/model/Todo.dart';
import 'package:error_proof_demo/state_management/ReduxStreamBuilder.dart';
import 'package:error_proof_demo/todolist/TodoActions.dart';
import 'package:error_proof_demo/todolist/TodoListInteractor.dart';
import 'package:error_proof_demo/todolist/TodoListState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TodoListScreen extends StatelessWidget {
  final TodoListInteractor _interactor = GetIt.I<TodoListInteractor>();

  final FocusNode _todoFocus = FocusNode();
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ReduxStreamBuilder<TodoListState>(
      stream: _interactor.state,
      builder: (context, snapshot) {
        TodoListState state = snapshot.data;
        return Scaffold(
          appBar: AppBar(title: Text("Список задач"),),
          body: Container(
              child: Stack(
                children: [
                  ListView.builder(
                      itemCount: state.todoItems.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: Key(state.todoItems[index].title),
                            background: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(bottom: 8,
                                  top: 8,
                                  right: 24.0),
                              child: Image.asset(
                                "images/bin.png",
                                width: 30,
                                height: 40,
                              ),
                            ),
                            onDismissed: (direction) {
                              _interactor.dispatch(state,
                                  RemoveTodoAction(index));
                            },
                            child: SizedBox(
                                height: 40.0,
                                child: Container(
                                  color: Colors.amber[100],
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(bottom: 1),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: <Widget>[
                                      Checkbox(
                                        value: state.todoItems[index].checked,
                                        onChanged: (value) {
                                          _interactor.dispatch(
                                              state, CheckTodoAction(index));
                                        },
                                      ),
                                      Text("${state.todoItems[index].title}")

                                    ],
                                  ),)));
                      }),
                  Visibility(
                    visible: state.isAdding,
                    child: Container(
                      color: Colors.black12.withOpacity(0.3),
                      child: Container(

                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 16.0),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Что надо сделать?',
                                ),
                                focusNode: _todoFocus,
                                onFieldSubmitted: (term) {
                                  _todoFocus.unfocus();
                                },
                                controller: _todoController,
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Center(
                              child: SizedBox(
                                height: 50,
                                width: 150,
                                child: RaisedButton(
                                  color: Colors.amber,
                                  shape:
                                  new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius
                                        .circular(30.0),
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());

                                    String title =_todoController.text;
                                    _todoController.text = "";

                                    _interactor.dispatch(state, AddTodoAction(
                                        Todo(title: title)));
                                  },
                                  child: Text(
                                    'Добавить',
                                    style: TextStyle(color: Colors.white,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ),
                  )
                ],
              ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _interactor.dispatch(state, ToggleAddingStateTodoAction());
            },
            child: state.isAdding?Icon(Icons.close):Icon(Icons.add),
            backgroundColor: Colors.amber,
          ),
        );
      },
    );
  }
}

