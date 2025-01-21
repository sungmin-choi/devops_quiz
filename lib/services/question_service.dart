import 'package:devops_quiz/config/app_config.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionService {
  static const String baseUrl = AppConfig.baseUrl;

  // enum을 id로 변환하는 메서드들
  int _getCategoryId(String categoryTitle) {
    switch (categoryTitle) {
      case 'Kubernetes':
        return 1;
      case 'Docker':
        return 2;
      case 'Networking':
        return 3;
      case 'Git':
        return 4;
      case 'CI/CD':
        return 5;
      case 'Linux':
        return 6;
      case 'CS':
        return 7;
      case 'Jenkins':
        return 8;
      case 'Ansible':
        return 9;
      default:
        throw Exception('Unknown category');
    }
  }

  int _getQuestionDifficultyId(QuestionDifficulty questionDifficulty) {
    switch (questionDifficulty) {
      case QuestionDifficulty.easy:
        return 1;
      case QuestionDifficulty.medium:
        return 2;
      case QuestionDifficulty.all:
        return 3;
    }
  }

  Future<List<Question>> fetchQuestions({
    required String categoryTitle,
    required QuizMode quizMode,
    required int questionCount,
    required QuestionDifficulty questionLevel,
  }) async {
    try {
      // enum을 id로 변환
      final categoryId = _getCategoryId(categoryTitle);
      final difficultyId = _getQuestionDifficultyId(questionLevel);

      print(
          'categoryId: $categoryId, difficultyId: $difficultyId, quizMode: ${quizMode.name}, questionCount: $questionCount');

      final response = await http.get(Uri.parse(
          '$baseUrl/questions?categoryId=$categoryId&mode=${quizMode.name}&count=$questionCount&difficultyId=$difficultyId'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        return jsonData.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching questions: $e');
      throw Exception('Failed to load questions: $e');
    }
  }
}
