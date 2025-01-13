import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/provider/answer_provider.dart';

class QuestionTrueFalse extends ConsumerWidget {
  const QuestionTrueFalse({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListTile(
            value: 'True',
            groupValue: ref.watch(currentAnswerProvider),
            onChanged: (value) {
              ref.read(currentAnswerProvider.notifier).state = value;
            },
            visualDensity: VisualDensity(
              horizontal: -4, // 왼쪽으로 더 이동
              vertical: -4, // 위아래 간격 축소
            ),
            fillColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(context).colorScheme.secondary;
                }
                return Colors.grey;
              },
            ),
            title: Text('참'),
          ),
          RadioListTile(
            value: 'False',
            groupValue: ref.watch(currentAnswerProvider),
            visualDensity: VisualDensity(
              horizontal: -4, // 왼쪽으로 더 이동
              vertical: -4, // 위아래 간격 축소
            ),
            fillColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(context).colorScheme.secondary;
                }
                return Colors.grey;
              },
            ),
            onChanged: (value) {
              ref.read(currentAnswerProvider.notifier).state = value;
            },
            title: Text('거짓'),
          ),
        ],
      ),
    );
  }
}
