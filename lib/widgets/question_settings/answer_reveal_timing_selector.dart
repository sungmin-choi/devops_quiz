import 'package:flutter/material.dart';

enum AnswerRevealTiming {
  afterEach,
  afterAll,
}

class AnswerRevealTimingSelector extends StatelessWidget {
  const AnswerRevealTimingSelector({
    super.key,
    required this.selectedTiming,
    required this.onTimingChanged,
  });

  final AnswerRevealTiming selectedTiming;
  final Function(AnswerRevealTiming) onTimingChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '정답 및 해설 공개 시점',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AnswerRevealTiming>(
              value: selectedTiming,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              items: [
                DropdownMenuItem(
                  value: AnswerRevealTiming.afterEach,
                  child: const Text(
                    '문제마다 정답 및 해설 공개',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: AnswerRevealTiming.afterAll,
                  child: const Text(
                    '모든 문제를 푼 후에 정답 및 해설 공개',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
              onChanged: (AnswerRevealTiming? value) {
                if (value != null) {
                  onTimingChanged(value);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            selectedTiming == AnswerRevealTiming.afterEach
                ? '문제를 풀 때마다 정답 및 해설을 바로 확인할 수 있습니다'
                : '모든 문제를 푼 후에 정답 및 해설을 확인할 수 있습니다',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}
