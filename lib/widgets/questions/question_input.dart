import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/provider/answer_provider.dart';

class QuestionInput extends ConsumerStatefulWidget {
  const QuestionInput({super.key});

  @override
  ConsumerState<QuestionInput> createState() => _QuestionInputState();
}

class _QuestionInputState extends ConsumerState<QuestionInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: ref.read(currentAnswerProvider.notifier).state ?? '');
  }

  @override
  void didUpdateWidget(QuestionInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Provider 값이 변경되면 controller 텍스트도 업데이트
    _controller.text = ref.read(currentAnswerProvider.notifier).state ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider 값 변경 감지
    final currentAnswer = ref.watch(currentAnswerProvider) ?? '';

    // Provider 값과 controller 값이 다르면 업데이트
    if (_controller.text != currentAnswer) {
      _controller.text = currentAnswer;
    }

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
        controller: _controller,
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
