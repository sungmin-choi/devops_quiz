import 'package:devops_quiz/models/category.dart';

enum QuestionType {
  singleChoice,
  multipleChoice,
  trueFalse,
  fillInTheBlank,
}

enum QuestionDifficulty {
  easy,
  medium,
  all,
}

class Question {
  final String questionId;
  final QuestionCategory category;
  final QuestionType questionType;
  final QuestionDifficulty difficulty;
  // 텍스트 문제를 위한 필드
  final String? questionText;

  // 이미지 문제를 위한 필드
  final String? imageUrl;
  final String? subText;
  final dynamic answer;
  final String? explanationText;
  final String? referenceLink;

  // 객관식 문제의 보기 목록
  final List<String>? options;

  Question({
    required this.questionId,
    required this.category,
    required this.questionType,
    required this.difficulty,
    this.questionText,
    this.imageUrl,
    this.subText,
    this.answer,
    this.explanationText,
    this.referenceLink,
    this.options,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['questionId'] ?? '',
      category: map['category'] ?? '',
      questionType: _stringToQuestionType(map['questionType']),
      difficulty: _stringToDifficulty(map['difficulty']),

      // 텍스트 / 이미지 모두 받아와서 저장
      questionText: map['questionText'],
      imageUrl: map['imageUrl'],

      subText: map['subText'],
      answer: map['answer'],
      explanationText: map['explanationText'],
      referenceLink: map['referenceLink'],
      options:
          map['options'] != null ? List<String>.from(map['options']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'category': category,
      'questionType': questionType.toString().split('.').last,
      'difficulty': difficulty.toString().split('.').last,
      'questionText': questionText,
      'imageUrl': imageUrl,
      'subText': subText,
      'answer': answer,
      'explanationText': explanationText,
      'referenceLink': referenceLink,
      'options': options,
    };
  }

  static QuestionType _stringToQuestionType(String? type) {
    switch (type) {
      case 'singleChoice':
        return QuestionType.singleChoice;
      case 'multipleChoice':
        return QuestionType.multipleChoice;
      case 'trueFalse':
        return QuestionType.trueFalse;
      case 'fillInTheBlank':
        return QuestionType.fillInTheBlank;
      default:
        return QuestionType.singleChoice; // 기본값
    }
  }

  static QuestionDifficulty _stringToDifficulty(String? diff) {
    switch (diff) {
      case 'easy':
        return QuestionDifficulty.easy;
      case 'medium':
        return QuestionDifficulty.medium;
      default:
        return QuestionDifficulty.easy; // 기본값
    }
  }
}
