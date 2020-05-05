import 'dart:async';

import 'Navigational.dart';
import 'State.dart' as SM;
import 'package:flutter/widgets.dart';

class ReduxStreamBuilder<T extends SM.State> extends StreamBuilderBase<T, AsyncSnapshot<T>> with Navigational {
  const ReduxStreamBuilder({
    Key key,
    this.initialData,
    Stream<T> stream,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key, stream: stream);

  final AsyncWidgetBuilder<T> builder;
  final T initialData;

  @override
  AsyncSnapshot<T> initial() =>
      AsyncSnapshot<T>.withData(ConnectionState.none, initialData);

  @override
  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.waiting);

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    return AsyncSnapshot<T>.withData(ConnectionState.active, data);
  }

  @override
  AsyncSnapshot<T> afterError(AsyncSnapshot<T> current, Object error) {
    return AsyncSnapshot<T>.withError(ConnectionState.active, error);
  }

  @override
  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) {
    return current.inState(ConnectionState.done);
  }

  @override
  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) {
    return current.inState(ConnectionState.none);
  }

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> currentSummary) {
    if (currentSummary.data == null) {
      return Container();
    }

    if (currentSummary.data.isNavigational && !currentSummary.data.handled) {
      currentSummary.data.handled = true;
      handleNavigation(context, currentSummary.data);
    }

    return builder(context, currentSummary);
  }
}
