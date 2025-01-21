import 'package:flutter/material.dart';
import 'package:devops_quiz/widgets/result/result_summary.dart';
import 'package:devops_quiz/models/category.dart';
import 'package:devops_quiz/provider/answers_provider.dart';
import 'package:devops_quiz/provider/questions_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/widgets/result/result_question_item.dart';
import 'package:devops_quiz/screens/categories.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key, required this.category});

  final Category category;

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  bool _isOnlyIncorrect = false;

  bool _checkCorrect(dynamic userAnswer, dynamic questionAnswer) {
    print('userAnswer: $userAnswer');
    print('questionAnswer: $questionAnswer');

    if (userAnswer is List && questionAnswer is List) {
      return questionAnswer.every((element) => userAnswer.contains(element));
    } else if (userAnswer is String && questionAnswer is String) {
      return userAnswer.toLowerCase() == questionAnswer.toLowerCase();
    } else {
      return userAnswer == questionAnswer;
    }
  }

  @override
  Widget build(BuildContext context) {
    final answers = ref.watch(answersProvider);
    final questions = ref.watch(questionsProvider);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios, // iOS 스타일 뒤로가기 아이콘
              size: 20, // 아이콘 크기 조절
            ),
            onPressed: () {
              ref.read(answersProvider.notifier).clear();
              ref.read(questionsProvider.notifier).clear();
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
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          ResultSummary(
                            isOnlyIncorrect: _isOnlyIncorrect,
                            onTapOnlyIncorrect: () {
                              setState(() {
                                _isOnlyIncorrect = !_isOnlyIncorrect;
                              });
                            },
                            category: widget.category,
                            questionsCount: questions.length,
                            correctCount: answers
                                .asMap()
                                .entries
                                .where((entry) => _checkCorrect(
                                    entry.value, questions[entry.key].answer))
                                .length,
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }
                    if (_isOnlyIncorrect) {
                      if (_checkCorrect(
                          answers[index - 1], questions[index - 1].answer)) {
                        return const SizedBox.shrink();
                      }
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
            ],
          ),
        ));
  }
}
