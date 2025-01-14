import 'package:flutter/material.dart';
import 'package:devops_quiz/widgets/result/result_summary.dart';
import 'package:devops_quiz/models/category.dart';
import 'package:devops_quiz/provider/answers_provider.dart';
import 'package:devops_quiz/provider/questions_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/widgets/result/result_question_item.dart';
import 'package:devops_quiz/screens/categories.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key, required this.category});

  final Category category;

  bool _checkCorrect(dynamic userAnswer, dynamic questionAnswer) {
    if (userAnswer is List && questionAnswer is List) {
      return questionAnswer.every((element) => userAnswer.contains(element));
    } else if (userAnswer is String && questionAnswer is String) {
      return userAnswer.toLowerCase() == questionAnswer.toLowerCase();
    } else {
      return userAnswer == questionAnswer;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(answersProvider);
    final questions = ref.watch(questionsProvider);

    print(answers);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, // iOS 스타일 뒤로가기 아이콘
            size: 20, // 아이콘 크기 조절
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CategoriesScreen(),
              ),
              (route) => false,
            );
          },
        ),
        title: Text('Quiz Result',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: ListView.builder(
            itemCount: questions.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    ResultSummary(category: category),
                    const SizedBox(height: 16),
                  ],
                );
              }
              return ResultQuestionItem(
                index: index - 1,
                question: questions[index - 1].questionText ?? '',
                userAnswer: answers[index - 1],
                correctAnswer: questions[index - 1].answer,
                explanation: questions[index - 1].explanationText ?? '',
                isCorrect: _checkCorrect(
                    answers[index - 1], questions[index - 1].answer),
              );
            },
          ),
        ),
      ),
    );
  }
}
