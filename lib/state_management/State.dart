abstract class State {
  bool handled = false;
  bool isNavigational = false;
  String navigationPath;
  String navigationMethod = "pushNamed";

  State({this.isNavigational = false, this.handled = false});
}
