import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/models/question.dart';

class AnswerProvider extends StateNotifier<dynamic> {
  AnswerProvider() : super(null);

  void setAnswerType(QuestionType answerType) {
    if (answerType == QuestionType.singleChoice ||
        answerType == QuestionType.multipleChoice) {
      state = [];
    } else if (answerType == QuestionType.fillInTheBlank) {
      state = '';
    } else if (answerType == QuestionType.trueFalse) {
      state = false;
    } else {
      state = null;
    }
  }

  void setAnswer(QuestionType answerType, dynamic answer) {
    if (answerType == QuestionType.singleChoice) {
      state = [answer];
    } else if (answerType == QuestionType.multipleChoice) {
      if (state.contains(answer)) {
        state = state.where((item) => item != answer).toList();
      } else {
        state = [...state, answer];
      }
    } else {
      state = answer;
    }
  }
}

final answerProvider =
    StateNotifierProvider<AnswerProvider, dynamic>((ref) => AnswerProvider());
