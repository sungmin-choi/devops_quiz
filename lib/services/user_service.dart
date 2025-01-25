import 'package:hive_flutter/hive_flutter.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/models/category.dart';

class UserService {
  final box = Hive.box('userBox');

  Category getCheckedCategory() {
    final checkedEasyCnt = box.get('checkedEasyCnt') ?? 0;
    final checkedMediumCnt = box.get('checkedMediumCnt') ?? 0;
    final checkedCnt = checkedEasyCnt + checkedMediumCnt;

    return Category(
      category: QuestionCategory.checked,
      title: 'Starred',
      subtitle: '체크한 문제집',
      imageUrl: 'assets/icons/star.svg',
      questionCount: checkedCnt,
      easyQuestionCount: checkedEasyCnt,
      mediumQuestionCount: checkedMediumCnt,
    );
  }

  List<dynamic> getCheckedQuestions() {
    final checkedQuestions = box.get('checkedQuestionIds') ?? [];
    return checkedQuestions.toList();
  }

  void addCheckedQuestion(Question question) {
    final checkedQuestions = getCheckedQuestions();
    checkedQuestions.add(question.questionId);
    box.put('checkedQuestionIds', checkedQuestions);

    if (question.difficulty == QuestionDifficulty.easy) {
      final easyCnt = box.get('checkedEasyCnt') ?? 0;
      box.put('checkedEasyCnt', easyCnt + 1);
    } else if (question.difficulty == QuestionDifficulty.medium) {
      final mediumCnt = box.get('checkedMediumCnt') ?? 0;
      box.put('checkedMediumCnt', mediumCnt + 1);
    }
  }

  void removeCheckedQuestion(Question question) {
    final checkedQuestions = getCheckedQuestions();
    checkedQuestions.remove(question.questionId);
    box.put('checkedQuestionIds', checkedQuestions);

    if (question.difficulty == QuestionDifficulty.easy) {
      final easyCnt = box.get('checkedEasyCnt') ?? 0;
      if (easyCnt > 0) {
        box.put('checkedEasyCnt', easyCnt - 1);
      }
    } else if (question.difficulty == QuestionDifficulty.medium) {
      final mediumCnt = box.get('checkedMediumCnt') ?? 0;
      if (mediumCnt > 0) {
        box.put('checkedMediumCnt', mediumCnt - 1);
      }
    }
  }
}
