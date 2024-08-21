import 'dart:async';

import '../model/function_item.dart';

class FunctionWrapper {
  String id;
  FunctionItem functionItem;

  FunctionWrapper({required this.id, required this.functionItem});
}

class Dispatcher {
  final StreamController<FunctionWrapper> _streamController = StreamController<FunctionWrapper>();
  late StreamSubscription<FunctionWrapper> _subscription;

  Dispatcher(Future<void> Function(FunctionWrapper) listen) {
    if (!_streamController.hasListener) {
      _subscription = _streamController.stream.listen((functionWrapper) async => await listen(functionWrapper));
    }
  }

  void dispatch(FunctionWrapper functionWrapper) {
    _streamController.add(functionWrapper);
  }

  void stop() {
    _subscription.cancel();
  }
}