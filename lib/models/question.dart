import 'dart:convert';

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

enum QuizMode {
  random,
  sort,
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

  factory Question.fromJson(Map<String, dynamic> map) {
    var rawAnswer = map['answer'];
    dynamic parsedAnswer;

    // answer 파싱 처리
    if (rawAnswer is String) {
      try {
        // JSON 문자열인 경우 디코딩 시도
        parsedAnswer = json.decode(rawAnswer);
      } catch (e) {
        // JSON 디코딩 실패시 원본 문자열 사용
        parsedAnswer = rawAnswer;
      }
    } else {
      // 이미 파싱된 데이터인 경우 그대로 사용
      parsedAnswer = rawAnswer;
    }

    return Question(
      questionId: map['questionId'] ?? '',
      questionText: map['questionText'],
      category: _IntToCategory(map['categoryId']),
      questionType: _IntToQuestionType(map['questionTypeId']),
      difficulty: _IntToDifficulty(map['difficultyId']),
      subText: map['subText'],
      imageUrl: map['imageUrl'],
      referenceLink: map['referenceLink'],
      explanationText: map['explanationText'],
      answer: parsedAnswer,
      options:
          map['options'] != null ? List<String>.from(map['options']) : null,
    );
  }

  Map<String, dynamic> toJson() {
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

  // ignore: non_constant_identifier_names
  static QuestionType _IntToQuestionType(int? typeId) {
    switch (typeId) {
      case 1:
        return QuestionType.singleChoice;
      case 2:
        return QuestionType.multipleChoice;
      case 3:
        return QuestionType.trueFalse;
      case 4:
        return QuestionType.fillInTheBlank;
      default:
        throw Exception('Unknown question type');
    }
  }

  // ignore: non_constant_identifier_names
  static QuestionCategory _IntToCategory(int? categoryId) {
    switch (categoryId) {
      case 1:
        return QuestionCategory.kubernetes;
      case 2:
        return QuestionCategory.docker;
      case 3:
        return QuestionCategory.networking;
      case 4:
        return QuestionCategory.git;
      case 5:
        return QuestionCategory.ciCd;
      case 6:
        return QuestionCategory.linux;
      case 7:
        return QuestionCategory.cs;
      case 8:
        return QuestionCategory.jenkins;
      case 9:
        return QuestionCategory.ansible;
      default:
        throw Exception('Unknown category');
    }
  }

  // ignore: non_constant_identifier_names
  static QuestionDifficulty _IntToDifficulty(int? difficultyId) {
    switch (difficultyId) {
      case 1:
        return QuestionDifficulty.easy;
      case 2:
        return QuestionDifficulty.medium;
      default:
        throw Exception('Unknown difficulty');
    }
  }
}
