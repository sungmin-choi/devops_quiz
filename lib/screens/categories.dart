import 'package:flutter/material.dart';
import 'package:devops_quiz/widgets/my_progress.dart';
import 'package:devops_quiz/widgets/category_item.dart';
import 'package:devops_quiz/models/category.dart';
import 'package:devops_quiz/services/category_service.dart';
// import 'package:devops_quiz/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final CategoryService categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DevOps Quiz',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
      ),
      body: FutureBuilder<List<Category>>(
        future: categoryService.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final categories = snapshot.data ?? [];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                MyProgress(),
                SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true, // GridView가 자신의 컨텐츠 크기만큼만 차지하도록 설정
                  physics:
                      NeverScrollableScrollPhysics(), // GridView 자체의 스크롤 비활성화
                  crossAxisCount: 2,
                  mainAxisSpacing: 10, // 세로 간격
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                  children: [
                    for (var category in categories)
                      CategoryItemWidget(category: category),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
