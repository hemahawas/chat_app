import 'dart:async';

class ItemStream<Type> {
  final StreamController<Type> _controller = StreamController<Type>.broadcast();
  Stream<Type> get stream => _controller.stream;

  void addItem(Type item) {
    _controller.add(item); // Add new events to the stream
  }

  void dispose() {
    _controller.close(); // Close the stream controller when done
  }
}
