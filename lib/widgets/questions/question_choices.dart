import 'package:flutter/material.dart';
import 'package:devops_quiz/widgets/questions/question_choice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/provider/answer_provider.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/provider/questions_provider.dart';
import 'package:devops_quiz/provider/answers_provider.dart';

class QuestionChoices extends ConsumerStatefulWidget {
  const QuestionChoices(
      {super.key,
      required this.options,
      required this.questionType,
      required this.index});

  final List<String> options;
  final QuestionType questionType;

  final int index;
  @override
  ConsumerState<QuestionChoices> createState() => _QuestionChoicesState();
}

class _QuestionChoicesState extends ConsumerState<QuestionChoices> {
  @override
  void initState() {
    super.initState();

    // Provider 초기화는 PostFrameCallback으로 이동
    // 위젯이 처음 생성될 때 첫 번째 프레임이 그려진 직후에 실행
    // 이 시점에서는 아직 위젯이 완전히 초기화되지 않았을 수 있으므로
    // 초기화 로직을 보장하기 위해 사용
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAnswer();
    });
  }

  void _initializeAnswer() {
    final answers = ref.read(answersProvider);
    if (answers.length > widget.index && answers[widget.index] != null) {
      ref
          .read(answerProvider.notifier)
          .setAnswer(widget.questionType, answers[widget.index]);
    } else {
      ref.read(answerProvider.notifier).setAnswerType(widget.questionType);
    }
  }

  bool _isSelected(dynamic answer, String option) {
    if (answer is List) {
      return answer.contains(option);
    }
    return answer == option;
  }

  @override
  Widget build(BuildContext context) {
    final answer = ref.watch(answerProvider);

    return Expanded(
      child: Scrollbar(
        thickness: 4,
        radius: const Radius.circular(8),
        thumbVisibility: false, // 스크롤 할 때만 표시
        trackVisibility: false, // 트랙 숨기기
        interactive: true,
        child: ListView.builder(
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            return QuestionChoice(
                questionType: widget.questionType,
                isSelected: _isSelected(answer, widget.options[index]),
                option: widget.options[index],
                index: index);
          },
        ),
      ),
    );
  }
}
