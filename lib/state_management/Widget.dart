import 'package:flutter/widgets.dart';
import 'State.dart' as SM;
import 'Interactor.dart';

@Deprecated("Not ready to use")
class ReduxWidget extends StatefulWidget {
  final Interactor _interactor;
  final Widget child;

  ReduxWidget(this._interactor, {@required this.child});

  @override
  _ReduxWidgetState createState() => _ReduxWidgetState(_interactor, child);
}

class _ReduxWidgetState extends State<ReduxWidget> {
  final Interactor _interactor;
  final Widget child;

  _ReduxWidgetState(this._interactor, this.child);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _interactor.state,
      builder: (context, snapshot) {
        SM.State data = snapshot.data;
        if (data == null) {
          return Container();
        }
        if (data.isNavigational) {

            Navigator.pushNamed(context, data.navigationPath);
          ;
          return null;
        }
        return child;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _interactor.dispose();
  }
}


mixin Navigational {
  void handleNavigation(BuildContext context, SM.State state) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Navigator.pushNamed(context, "/list");
    });
  }
}