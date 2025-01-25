enum QuestionCategory {
  kubernetes,
  docker,
  networking,
  git,
  ciCd,
  linux,
  cs,
  jenkins,
  ansible,
  checked
}

class Category {
  final QuestionCategory category;
  final String title;
  final String subtitle;
  final String imageUrl;
  final int questionCount;
  final int easyQuestionCount;
  final int mediumQuestionCount;

  Category({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.questionCount,
    required this.easyQuestionCount,
    required this.mediumQuestionCount,
  });

  // JSON에서 Category 객체로 변환
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: _getCategoryFromString(json['id'].toString()), // id를 enum으로 변환
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['image_url'],
      questionCount: int.parse(json['total_question_count'].toString()),
      easyQuestionCount: int.parse(json['easy_question_count'].toString()),
      mediumQuestionCount: int.parse(json['medium_question_count'].toString()),
    );
  }

  // 문자열을 QuestionCategory enum으로 변환하는 헬퍼 메서드
  static QuestionCategory _getCategoryFromString(String id) {
    switch (id) {
      case '1':
        return QuestionCategory.kubernetes;
      case '2':
        return QuestionCategory.docker;
      case '3':
        return QuestionCategory.networking;
      case '4':
        return QuestionCategory.git;
      case '5':
        return QuestionCategory.ciCd;
      case '6':
        return QuestionCategory.linux;
      case '7':
        return QuestionCategory.cs;
      case '8':
        return QuestionCategory.jenkins;
      case '9':
        return QuestionCategory.ansible;
      default:
        throw Exception('Unknown category id: $id');
    }
  }
}
