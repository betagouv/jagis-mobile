import 'dart:async';

const resetPointsTopic = 'reset_points';
const startFirstTimeQuestionsToPersonalizeActionsTopic = 'start_first_time_questions_to_personalize_actions';
const actionDoneTopic = 'action_done';

class MessageBus {
  MessageBus({final bool sync = false}) : _controller = StreamController<String>.broadcast(sync: sync);

  final StreamController<String> _controller;

  Stream<String> subscribe(final String topic) => _controller.stream.where((final event) => event == topic).cast();

  void publish(final String topic) {
    if (_controller.isClosed) {
      return;
    }
    _controller.add(topic);
  }

  Future<void> close() async {
    await _controller.close();
  }
}
