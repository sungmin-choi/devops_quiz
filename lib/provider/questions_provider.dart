import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/services/question_service.dart';

class QuestionsProvider extends StateNotifier<List<Question>> {
  QuestionsProvider() : super([]);
  final questionService = QuestionService();

  Future<void> loadQuestions(String categoryTitle, QuizMode quizMode,
      int questionCount, QuestionDifficulty questionLevel,
      {List<dynamic> questionIds = const []}) async {
    List<Question> questions = [];
    try {
      if (categoryTitle == 'Starred' || categoryTitle == 'Review Sheet') {
        questions = await questionService.fetchQuestionsByIds(
          questionIds: questionIds,
          quizMode: quizMode,
          questionCount: questionCount,
          questionLevel: questionLevel,
        );
      } else {
        questions = await questionService.fetchQuestions(
          categoryTitle: categoryTitle,
          quizMode: quizMode,
          questionCount: questionCount,
          questionLevel: questionLevel,
        );
      }

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
