import 'package:flutter/material.dart';
import 'package:devops_quiz/models/category.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:devops_quiz/screens/question_settings.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget(
      {super.key, required this.category, required this.loadData});

  final Category category;
  final Function() loadData;

  void _goToQuestionSettingsScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QuestionSettingsScreen(category: category)),
    );
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: 18.0,
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(20),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(category.imageUrl, width: 30, height: 30),
              SizedBox(width: 15),
              Text(
                category.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Text(
              category.subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 86, 85, 85),
                  ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '총 ${category.questionCount}문제',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () => _goToQuestionSettingsScreen(context),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(double.infinity, 20),
            ),
            child: const Text('퀴즈 시작',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
