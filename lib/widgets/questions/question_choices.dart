import 'package:flutter/material.dart';
import 'package:devops_quiz/widgets/questions/question_choice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/provider/answer_provider.dart';

class QuestionChoices extends ConsumerWidget {
  const QuestionChoices(
      {super.key,
      required this.options,
      required this.questionType,
      required this.index});

  final List<String> options;
  final QuestionType questionType;
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAnswers = ref.watch(currentAnswerProvider);

    void handleAnswerChange(String option) {
      if (questionType == QuestionType.singleChoice) {
        ref.read(currentAnswerProvider.notifier).state = [option];
      } else {
        var newAnswers = List<String>.from(currentAnswers);
        if (newAnswers.contains(option)) {
          newAnswers.remove(option);
        } else {
          newAnswers.add(option);
        }
        ref.read(currentAnswerProvider.notifier).state = newAnswers;
      }
    }

    return Expanded(
      child: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => handleAnswerChange(options[index]),
            child: QuestionChoice(
              isSelected: currentAnswers.contains(options[index]),
              option: options[index],
              index: index,
              questionType: questionType,
            ),
          );
        },
      ),
    );
  }
}
