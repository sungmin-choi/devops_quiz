import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultQuestionItem extends StatelessWidget {
  final int index;
  final String question;
  final dynamic userAnswer;
  final dynamic correctAnswer;
  final String explanation;
  final bool isCorrect;
  final String? referenceLink;
  const ResultQuestionItem(
      {super.key,
      required this.index,
      required this.question,
      required this.userAnswer,
      required this.correctAnswer,
      required this.explanation,
      required this.isCorrect,
      required this.referenceLink});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView, // 외부 브라우저에서 열기
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide.none, // 테두리 선 제거
        ),
        child: ExpansionTile(
          iconColor: Colors.black, // 펼쳐졌을 때 아이콘 색상
          collapsedIconColor: Colors.black, // 접혔을 때 아
          shape: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          collapsedShape: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          leading: CircleAvatar(
            radius: 11,
            backgroundColor:
                isCorrect ? Colors.green[100] : Colors.red[100], // 배경색
            child: Icon(
              weight: 800.0,
              isCorrect ? Icons.check : Icons.close,
              color: isCorrect ? Colors.green : Colors.red, // 아이콘 색상을 흰색으로
              size: 14,
            ),
          ),
          title: Text('Question ${index + 1}',
              style: Theme.of(context).textTheme.titleMedium),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green[50] : Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Your answer (${isCorrect ? "Correct" : "Incorrect"}): $userAnswer',
                            style: TextStyle(
                              color: isCorrect
                                  ? Colors.green[900]
                                  : Colors.red[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isCorrect) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Correct answer: $correctAnswer',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.info_outline, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          explanation,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  if (referenceLink != null) ...[
                    TextButton.icon(
                      onPressed: () => _launchUrl(referenceLink!),
                      icon: Icon(Icons.link, color: Colors.blue[300]),
                      label: Text('Learn more',
                          style: TextStyle(color: Colors.blue[300])),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ));
  }
}
