import 'package:flutter/material.dart';
import 'package:devops_quiz/screens/question_settings.dart';
import 'package:devops_quiz/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devops_quiz/provider/answers_provider.dart';
import 'package:devops_quiz/provider/answer_provider.dart';

class ResultSummary extends ConsumerStatefulWidget {
  const ResultSummary({super.key, required this.category});

  final Category category;

  @override
  ConsumerState<ResultSummary> createState() => _ResultSummaryState();
}

class _ResultSummaryState extends ConsumerState<ResultSummary> {
  bool _isOnlyIncorrect = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '8/10 정답',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                ],
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: CircularProgressIndicator(
                      value: 0.8, // 80%
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      strokeWidth: 10,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        '80%',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton.icon(
                  icon:
                      const Icon(Icons.refresh, size: 16, color: Colors.white),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionSettingsScreen(
                          category: widget.category,
                        ),
                      ),
                      (route) => false,
                    );

                    //Provider 상태도 초기화
                    ref.read(answersProvider.notifier).clear();
                    ref.read(currentAnswerProvider.notifier).state = [];
                    //필요한 다른 Provider 초기화도 여기서 수행
                  },
                  label: Text('다시 풀기'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isOnlyIncorrect = !_isOnlyIncorrect;
                    });
                  },
                  child: Text(_isOnlyIncorrect ? '전체 보기' : '오답만 보기'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
