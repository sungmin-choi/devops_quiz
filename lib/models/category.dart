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
}

class Category {
  final QuestionCategory category;
  final String title;
  final String subtitle;
  final String imageUrl;
  final int questionCount;

  Category({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.questionCount,
  });
}
