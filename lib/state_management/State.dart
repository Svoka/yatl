import 'Navigational.dart';

abstract class State {
  bool handled = false;
  bool isNavigational = false;
  String navigationPath;
  NavigationMethod navigationMethod = NavigationMethod.pushNamed;

  State({this.isNavigational = false, this.handled = false, this.navigationPath, this.navigationMethod = NavigationMethod.pushNamed});
}

