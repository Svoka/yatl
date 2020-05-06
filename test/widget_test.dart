import 'package:yatl/login/LoginState.dart';
import 'package:yatl/login/LoginScreen.dart';
import 'package:yatl/model/Todo.dart';
import 'package:yatl/todolist/TodoListScreen.dart';
import 'package:yatl/todolist/TodoListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  LoginCallback onLoginPressed = (username, password){};

  testWidgets('Login field should contain text', (WidgetTester tester) async {
    LoginState state = LoginState.create(username: "UT");

    await tester.pumpWidget(TestWidgetsWrapper(child: LoginPage(state: state, onLoginPressed: onLoginPressed,),),);
    expect(find.text('UT'), findsOneWidget);

    state.password = "PWD";
    await tester.pumpWidget(TestWidgetsWrapper(child: LoginPage(state: state, onLoginPressed: onLoginPressed,),),);
    expect(find.text('PWD'), findsOneWidget);
  });

  testWidgets('Password field should contain text', (WidgetTester tester) async {
    LoginState state = LoginState.create(password: "PWD");

    await tester.pumpWidget(TestWidgetsWrapper(child: LoginPage(state: state, onLoginPressed: onLoginPressed,),),);
    expect(find.text('PWD'), findsOneWidget);
  });

  testWidgets('Password field should contain error text', (WidgetTester tester) async {
    LoginState state = LoginState.create(errors: Map.fromEntries([MapEntry(LoginError.password, 'PWD_ERROR')]));

    await tester.pumpWidget(TestWidgetsWrapper(child: LoginPage(state: state, onLoginPressed: onLoginPressed,),),);
    expect(find.text('PWD'), findsNothing);
    expect(find.text('PWD_ERROR'), findsOneWidget);
  });


  testWidgets('Has two items', (WidgetTester tester) async {
    TodoListState state = TodoListState.create(todoItems: [
      Todo(title: "T1", checked: true),
      Todo(title: "T1", checked: false),
    ]);

    await tester.pumpWidget(TestWidgetsWrapper(child: TodoListPage(
      state: state,
    )));
    expect(find.text('T1'), findsNWidgets(2));
  });


  testWidgets('Dismiss is working', (WidgetTester tester) async {
    TodoListState state = TodoListState.create(todoItems: [
      Todo(title: "T1", checked: true),
    ]);

    await tester.pumpWidget(TestWidgetsWrapper(child: TodoListPage(
      state: state,
      removeCallback: (index) {},
    )));
    expect(find.text('T1'), findsNWidgets(1));

    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    expect(find.text('T1'), findsNothing);

  });


  testWidgets('Items is checked', (WidgetTester tester) async {
    TodoListState state = TodoListState.create(todoItems: [
      Todo(title: "T1", checked: false),
      Todo(title: "T2", checked: true),
    ]);

    await tester.pumpWidget(TestWidgetsWrapper(child: TodoListPage(
      state: state,
    )));

    expect(find.text('T1'), findsNWidgets(1));
    expect(CheckedFinder(true), findsNWidgets(1));
  });


}

class CheckedFinder extends MatchFinder {
  CheckedFinder(this.value, { bool skipOffstage = true }) : super(skipOffstage: skipOffstage);

  final bool value;

  @override
  String get description => 'value "$value"';

  @override
  bool matches(Element candidate) {
    final Widget widget = candidate.widget;
    return widget is Checkbox && widget.value == value;
  }
}

class TestWidgetsWrapper extends StatelessWidget {
  final Widget child;
  TestWidgetsWrapper({this.child});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: child,),);
  }
}
