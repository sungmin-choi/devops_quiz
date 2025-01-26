import 'package:hive_flutter/hive_flutter.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/models/category.dart';

class UserInfo {
  final int correctPercent;
  final int totalResolvedCount;

  UserInfo({
    required this.correctPercent,
    required this.totalResolvedCount,
  });
}

class UserService {
  final box = Hive.box('userBox');

  UserInfo getUserInfo() {
    final correctPercent = box.get('correctPercent') ?? 0;
    final totalResolvedCount = box.get('totalResolvedCount') ?? 0;
    return UserInfo(
      correctPercent: correctPercent,
      totalResolvedCount: totalResolvedCount,
    );
  }

  void setUserInfo(int resolvedCount, int correctCount) {
    final currentTotalResolvedCount = box.get('totalResolvedCount') ?? 0;
    final currentCorrectPercent = box.get('correctPercent') ?? 0;

    final correctPercent =
        ((currentTotalResolvedCount * (currentCorrectPercent / 100)) +
                correctCount) /
            (resolvedCount + currentTotalResolvedCount) *
            100;

    box.put('correctPercent', correctPercent.round());
    box.put('totalResolvedCount', resolvedCount + currentTotalResolvedCount);
  }

  void initUserInfo() {
    box.put('correctPercent', 0);
    box.put('totalResolvedCount', 0);
    box.put('checkedEasyCnt', 0);
    box.put('checkedMediumCnt', 0);
    box.put('checkedQuestionIds', []);
  }

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
