import 'package:flutter/material.dart';
import 'package:devops_quiz/models/category.dart';
import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/widgets/question_settings/question_mode_selector.dart';
import 'package:devops_quiz/widgets/question_settings/question_count_slider.dart';
import 'package:devops_quiz/widgets/question_settings/question_level_selector.dart';
import 'package:devops_quiz/widgets/question_settings/answer_reveal_timing_selector.dart';
// import 'package:devops_quiz/widgets/question_settings/starred_problems_selecter.dart';
import 'package:devops_quiz/screens/questions.dart';

class QuestionSettingsScreen extends StatefulWidget {
  const QuestionSettingsScreen({super.key, required this.category});

  final Category category;

  @override
  State<QuestionSettingsScreen> createState() => _QuestionSettingsScreenState();
}

class _QuestionSettingsScreenState extends State<QuestionSettingsScreen> {
  QuizMode _quizMode = QuizMode.random;
  double _questionCount = 1;
  int _maxQuestionCount = 0;
  QuestionDifficulty _questionLevel = QuestionDifficulty.all;
  AnswerRevealTiming _answerRevealTiming = AnswerRevealTiming.afterEach;
  // StarredProblemsSelectorMode _starredProblemsSelectorMode =
  //     StarredProblemsSelectorMode.all;

  @override
  void initState() {
    super.initState();
    _questionCount = widget.category.questionCount.toDouble();
    _maxQuestionCount = widget.category.questionCount;
  }

  void _navigateToQuestionsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionsScreen(
          category: widget.category,
          quizMode: _quizMode,
          questionCount: _questionCount.round(),
          questionLevel: _questionLevel,
          answerRevealTiming: _answerRevealTiming,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Quiz Settings (${widget.category.title})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionModeSelector(
                      selectedMode: _quizMode,
                      onModeChanged: (QuizMode newMode) {
                        setState(() {
                          _quizMode = newMode;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
                    QuestionCountSlider(
                      questionCount: _questionCount,
                      onChanged: (double value) {
                        setState(() {
                          _questionCount = value;
                        });
                      },
                      max: _maxQuestionCount,
                    ),
                    const SizedBox(height: 22),
                    QuestionLevelSelector(
                      selectedLevel: _questionLevel,
                      onLevelChanged: (QuestionDifficulty newLevel) {
                        setState(() {
                          _questionLevel = newLevel;
                        });
                        if (_questionLevel == QuestionDifficulty.easy) {
                          setState(() {
                            _questionCount =
                                widget.category.easyQuestionCount.toDouble();
                            _maxQuestionCount =
                                widget.category.easyQuestionCount;
                          });
                        } else if (_questionLevel ==
                            QuestionDifficulty.medium) {
                          setState(() {
                            _questionCount =
                                widget.category.mediumQuestionCount.toDouble();
                            _maxQuestionCount =
                                widget.category.mediumQuestionCount;
                          });
                        } else {
                          setState(() {
                            _questionCount =
                                widget.category.questionCount.toDouble();
                            _maxQuestionCount = widget.category.questionCount;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 22),
                    AnswerRevealTimingSelector(
                      selectedTiming: _answerRevealTiming,
                      onTimingChanged: (AnswerRevealTiming newTiming) {
                        setState(() {
                          _answerRevealTiming = newTiming;
                        });
                      },
                    ),
                    // const SizedBox(height: 22),
                    // StarredProblemsSelector(
                    //   selectedMode: _starredProblemsSelectorMode,
                    //   onModeChanged: (StarredProblemsSelectorMode newMode) {
                    //     setState(() {
                    //       _starredProblemsSelectorMode = newMode;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _navigateToQuestionsScreen(),
              child: Text('퀴즈 풀기',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
