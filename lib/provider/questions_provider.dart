import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/services/question_service.dart';

class QuestionsProvider extends StateNotifier<List<Question>> {
  QuestionsProvider() : super([]);
  final questionService = QuestionService();

  Future<void> loadQuestions(String categoryTitle, QuizMode quizMode,
      int questionCount, QuestionDifficulty questionLevel) async {
    try {
      final questions = await questionService.fetchQuestions(
        categoryTitle: categoryTitle,
        quizMode: quizMode,
        questionCount: questionCount,
        questionLevel: questionLevel,
      );

      state = questions;
    } catch (e) {
      rethrow;
    }
  }

  void clear() {
    state = [];
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionsProvider, List<Question>>(
  (ref) => QuestionsProvider(),
);
