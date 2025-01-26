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
    box.put('wrongEasyCnt', 0);
    box.put('wrongMediumCnt', 0);
    box.put('wrongQuestionIds', []);
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

  Category getWrongCategory() {
    final wrongEasyCnt = box.get('wrongEasyCnt') ?? 0;
    final wrongMediumCnt = box.get('wrongMediumCnt') ?? 0;
    final wrongCnt = wrongEasyCnt + wrongMediumCnt;

    return Category(
      category: QuestionCategory.checked,
      title: 'Review Sheet',
      subtitle: '오답노트',
      imageUrl: 'assets/icons/note.svg',
      questionCount: wrongCnt,
      easyQuestionCount: wrongEasyCnt,
      mediumQuestionCount: wrongMediumCnt,
    );
  }

  List<dynamic> getWrongQuestionsIds() {
    final wrongQuestions = box.get('wrongQuestionIds') ?? [];
    return wrongQuestions.toList();
  }

  void removeWrongQuestion(Question question) {
    var wrongEasyCnt = box.get('wrongEasyCnt') ?? 0;
    var wrongMediumCnt = box.get('wrongMediumCnt') ?? 0;
    final wrongQuestions = getWrongQuestionsIds();

    wrongQuestions.remove(question.questionId);
    if (question.difficulty == QuestionDifficulty.easy) {
      wrongEasyCnt--;
    } else if (question.difficulty == QuestionDifficulty.medium) {
      wrongMediumCnt--;
    }

    if (wrongEasyCnt < 0) {
      wrongEasyCnt = 0;
    }
    if (wrongMediumCnt < 0) {
      wrongMediumCnt = 0;
    }

    box.put('wrongQuestionIds', wrongQuestions);
    box.put('wrongEasyCnt', wrongEasyCnt);
    box.put('wrongMediumCnt', wrongMediumCnt);
  }

  void addWrongQuestion(List<Question> wrongQuestions) {
    var wrongEasyCnt = box.get('wrongEasyCnt') ?? 0;
    var wrongMediumCnt = box.get('wrongMediumCnt') ?? 0;
    final wrongQuestionIds = getWrongQuestionsIds();

    final newWrongQuestions = wrongQuestions
        .map((question) =>
            wrongQuestionIds.contains(question.questionId) ? null : question)
        .where((question) => question != null)
        .toList();

    for (var question in newWrongQuestions) {
      if (question!.difficulty == QuestionDifficulty.easy) {
        wrongEasyCnt++;
      } else if (question.difficulty == QuestionDifficulty.medium) {
        wrongMediumCnt++;
      }
    }

    wrongQuestionIds
        .addAll(newWrongQuestions.map((question) => question!.questionId));
    box.put('wrongQuestionIds', wrongQuestionIds);
    box.put('wrongEasyCnt', wrongEasyCnt);
    box.put('wrongMediumCnt', wrongMediumCnt);
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
