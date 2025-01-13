import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/provider/answer_provider.dart';

class QuestionInput extends ConsumerWidget {
  const QuestionInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          ref.read(currentAnswerProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey[300]!, // 기본 테두리 색상
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            // 일반 상태 테두리
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // 포커스 상태 테두리
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary, // 포커스시 색상
              width: 2.0, // 포커스시 두께
            ),
          ),
          hintText: '답안을 입력하세요',
        ),
      ),
    );
  }
}
