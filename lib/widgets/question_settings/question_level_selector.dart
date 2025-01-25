import 'package:flutter/material.dart';
import 'package:devops_quiz/models/question.dart';

class QuestionLevelSelector extends StatelessWidget {
  const QuestionLevelSelector({
    super.key,
    required this.selectedLevel,
    required this.onLevelChanged,
    required this.easyQuestionCount,
    required this.mediumQuestionCount,
  });

  final QuestionDifficulty selectedLevel;
  final void Function(QuestionDifficulty) onLevelChanged;
  final int easyQuestionCount;
  final int mediumQuestionCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '문제 난이도',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        RadioListTile(
          value: QuestionDifficulty.all,
          groupValue: selectedLevel,
          contentPadding: EdgeInsets.zero,
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.secondary;
              }
              return Colors.grey;
            },
          ),
          visualDensity: VisualDensity(
            horizontal: -4, // 왼쪽으로 더 이동
            vertical: -4, // 위아래 간격 축소
          ),
          onChanged: (QuestionDifficulty? value) {
            onLevelChanged(value!);
          },
          title: Text('전체'),
        ),
        RadioListTile(
          value: QuestionDifficulty.easy,
          groupValue: selectedLevel,
          contentPadding: EdgeInsets.zero, // 좌우 패딩 제거
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.secondary;
              }
              return Colors.grey;
            },
          ),
          visualDensity: VisualDensity(
            horizontal: -4, // 왼쪽으로 더 이동
            vertical: -4, // 위아래 간격 축소
          ),
          onChanged: easyQuestionCount > 0
              ? (QuestionDifficulty? value) {
                  onLevelChanged(value!);
                }
              : null,
          title: Text(
            '쉬움',
            style: easyQuestionCount > 0
                ? TextStyle(color: Colors.black)
                : TextStyle(color: Colors.grey),
          ),
        ),
        RadioListTile(
          value: QuestionDifficulty.medium,
          groupValue: selectedLevel,
          contentPadding: EdgeInsets.zero, // 좌우 패딩 제거
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.secondary;
              }
              return Colors.grey;
            },
          ),
          visualDensity: VisualDensity(
            horizontal: -4, // 왼쪽으로 더 이동
            vertical: -4, // 위아래 간격 축소
          ),
          onChanged: mediumQuestionCount > 0
              ? (QuestionDifficulty? value) {
                  onLevelChanged(value!);
                }
              : null,
          title: Text(
            '보통',
            style: mediumQuestionCount > 0
                ? TextStyle(color: Colors.black)
                : TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
