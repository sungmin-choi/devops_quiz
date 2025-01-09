import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/provider/answer_provider.dart';
import 'package:devops_quiz/models/question.dart';

class QuestionChoice extends ConsumerWidget {
  const QuestionChoice({
    super.key,
    required this.option,
    required this.isSelected,
    required this.index,
    required this.questionType,
  });

  final String option;
  final bool isSelected;
  final int index;
  final QuestionType questionType;
  String _indexToAlphabet(int index) {
    return String.fromCharCode(index + 65);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(answerProvider.notifier).setAnswer(questionType, option);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 74,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text('${_indexToAlphabet(index)}. ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    )),
            const SizedBox(width: 10),
            Expanded(child: Text(option)),
          ],
        ),
      ),
    );
  }
}
