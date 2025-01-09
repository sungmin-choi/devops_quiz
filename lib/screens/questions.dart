import 'package:flutter/material.dart';
import 'package:devops_quiz/models/category.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/widgets/question_settings/question_mode_selector.dart';
import 'package:devops_quiz/widgets/question_settings/answer_reveal_timing_selector.dart';
import 'package:devops_quiz/data/dummy_data.dart';
import 'package:devops_quiz/widgets/questions/question_choices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/provider/questions_provider.dart';
import 'package:devops_quiz/provider/answer_provider.dart';

class QuestionsScreen extends ConsumerStatefulWidget {
  const QuestionsScreen(
      {super.key,
      required this.category,
      required this.quizMode,
      required this.questionCount,
      required this.questionLevel,
      required this.answerRevealTiming});

  final Category category;
  final QuizMode quizMode;
  final int questionCount;
  final QuestionDifficulty questionLevel;
  final AnswerRevealTiming answerRevealTiming;

  @override
  ConsumerState<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  int _currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(questionsProvider.notifier).loadQuestions(kubernetesQuestions);
    });
  }

  bool _enableNextButton(List<Question> questions, int index) {
    if (questions.isEmpty) {
      return false;
    }
    if (questions[index].questionType == QuestionType.singleChoice) {
      return ref.watch(answerProvider).isNotEmpty;
    } else if (questions[index].questionType == QuestionType.multipleChoice) {
      return ref.watch(answerProvider).length > 1;
    } else {
      return ref.watch(answerProvider) != null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(questionsProvider);

    Widget buildQuestions(List<Question> questions, int index) {
      if (questions.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (questions[index].questionType == QuestionType.singleChoice ||
          questions[index].questionType == QuestionType.multipleChoice) {
        return QuestionChoices(
            questionType: questions[index].questionType,
            index: index,
            options: questions[index].options ?? []);
      }

      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, // iOS 스타일 뒤로가기 아이콘
            size: 20, // 아이콘 크기 조절
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('${widget.category.title} Quiz',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Question ${_currentQuestionIndex + 1} /${widget.questionCount}',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  )),
                      Row(
                        children: [
                          IconButton(
                              style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                              onPressed: () {},
                              icon: const Icon(Icons.star_border_outlined)),
                          const SizedBox(width: 10),
                          IconButton(
                              style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.lightbulb_outline_rounded)),
                        ],
                      )
                    ]),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                          questions.isEmpty
                              ? ''
                              : questions[_currentQuestionIndex].questionText ??
                                  '',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  )),
                      const SizedBox(height: 16),
                      Text(
                          questions.isEmpty
                              ? ''
                              : questions[_currentQuestionIndex].subText ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: const Color.fromARGB(221, 40, 39, 39),
                              )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                buildQuestions(questions, _currentQuestionIndex),
                const SizedBox(height: 68),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 78,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[300]!, // 회색 테두리
                    width: 1.0, // 테두리 두께
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.black, // 연한 회색
                        ),
                        onPressed: _currentQuestionIndex > 0
                            ? () {
                                setState(() {
                                  _currentQuestionIndex--;
                                });
                              }
                            : null,
                        child: Text('이전 문제',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed:
                            _enableNextButton(questions, _currentQuestionIndex)
                                ? () {
                                    setState(() {
                                      _currentQuestionIndex++;
                                    });
                                  }
                                : null,
                        child: Text('다음 문제',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
