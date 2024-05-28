import 'dart:async';
import 'package:get/get.dart';

class EventBus extends GetxService {
  final _eventStream = StreamController.broadcast();

  Stream<T> on<T>() {
    return _eventStream.stream.where((event) => event is T).cast<T>();
  }

  void fire(event) {
    _eventStream.add(event);
  }

  @override
  void onClose() {
    _eventStream.close();
    super.onClose();
  }
}
