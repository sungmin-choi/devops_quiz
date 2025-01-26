import 'package:flutter/material.dart';
import 'package:devops_quiz/widgets/my_progress.dart';
import 'package:devops_quiz/widgets/category_item.dart';
import 'package:devops_quiz/models/category.dart';
import 'package:devops_quiz/services/category_service.dart';
import 'package:devops_quiz/services/user_service.dart';
// import 'package:devops_quiz/data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoryService categoryService = CategoryService();
  final userService = UserService();
  late Category _checkedCategory;
  late Future<List<Category>> _categoriesFuture;
  late UserInfo _userInfo;

  void _loadData() {
    _checkedCategory = userService.getCheckedCategory();
    _categoriesFuture = categoryService.fetchCategories();
    _userInfo = userService.getUserInfo();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

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
        future: _categoriesFuture,
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
                MyProgress(
                    userInfo: _userInfo,
                    userService: userService,
                    loadData: _loadData),
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
                    if (_checkedCategory.questionCount > 0)
                      CategoryItemWidget(
                          category: _checkedCategory, loadData: _loadData),
                    for (var category in categories)
                      if (category.questionCount > 0)
                        CategoryItemWidget(
                            category: category, loadData: _loadData),
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
