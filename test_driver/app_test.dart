import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {
  FlutterDriver driver;

  final usernameFinder = find.byValueKey('usernameField');
  final passwordFinder = find.byValueKey('passwordField');
  final loginButtonFinder = find.byValueKey('loginButtonText');
  final addFabFinder = find.byValueKey('addTodoFab');
  final newTaskTextFinder = find.byValueKey('newTaskTextField');
  final newTaskButtonFinder = find.byValueKey('newTaskButton');

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });


  test('We start at login screen', () async {
    expect(await driver.getText(loginButtonFinder), 'ОТПРАВИТЬ');
  });

  test('We can login', () async {
    await driver.tap(usernameFinder);
    await driver.enterText('1234');


    await driver.tap(passwordFinder);
    await driver.enterText('1234');

    await driver.tap(loginButtonFinder);
  });

  test ('We see todo-list', () async {
      String title  = 'Test to-do adding';

      await driver.waitFor(addFabFinder, timeout: Duration(milliseconds: 1000));

      await driver.tap(addFabFinder);

      await driver.tap(newTaskTextFinder);
      await driver.enterText(title, timeout: Duration(milliseconds: 200));
      await driver.tap(newTaskButtonFinder);


      expect(await driver.getText(find.byValueKey('T_$title')), title);

  });

}