import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswersProvider extends StateNotifier<List<dynamic>> {
  AnswersProvider() : super([]);

  void addAnswer(int index, dynamic answer) {
    if (state.length <= index) {
      state = [...state, answer];
    } else {
      state[index] = answer;
    }
  }

  void clear() {
    state = [];
  }
}

final answersProvider = StateNotifierProvider<AnswersProvider, List<dynamic>>(
  (ref) => AnswersProvider(),
);
