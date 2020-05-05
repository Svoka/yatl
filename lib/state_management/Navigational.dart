import 'package:flutter/widgets.dart';
import 'State.dart' as SM;



mixin Navigational {
  void handleNavigation(BuildContext context, SM.State state) {
    WidgetsBinding.instance.addPostFrameCallback((_){

      switch (state.navigationMethod) {
        case NavigationMethod.pushNamed:
          Navigator.pushNamed(context, state.navigationPath);
          break;
        case NavigationMethod.pushReplacementNamed:
          Navigator.pushReplacementNamed(context, state.navigationPath);
          break;
      }
    });
  }
}


enum NavigationMethod {
  pushNamed, pushReplacementNamed
}