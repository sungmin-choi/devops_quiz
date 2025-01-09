import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/models/question.dart';

class QuestionsProvider extends StateNotifier<List<Question>> {
  QuestionsProvider() : super([]);

  void loadQuestions(List<Question> questions) {
    final shuffledQuestions = questions.map((question) {
      if (question.options != null) {
        question.options?.shuffle();
      }
      return question;
    });

    state = shuffledQuestions.toList();
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionsProvider, List<Question>>(
  (ref) => QuestionsProvider(),
);
