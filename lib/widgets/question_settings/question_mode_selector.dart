import 'package:flutter/material.dart';
import 'package:devops_quiz/models/question.dart';

class QuestionModeSelector extends StatelessWidget {
  const QuestionModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  final QuizMode selectedMode;
  final void Function(QuizMode) onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '퀴즈 모드',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SegmentedButton<QuizMode>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment<QuizMode>(
              value: QuizMode.random,
              label: Text('문제 랜덤'),
            ),
            ButtonSegment<QuizMode>(
              value: QuizMode.sort,
              label: Text('정렬'),
            ),
          ],
          selected: {selectedMode},
          onSelectionChanged: (Set<QuizMode> newSelection) {
            onModeChanged(newSelection.first);
          },
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            )),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(context).colorScheme.secondary;
                }
                return const Color.fromARGB(255, 224, 222, 222);
              },
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return Colors.black;
              },
            ),
            side: WidgetStateProperty.all(BorderSide.none),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
