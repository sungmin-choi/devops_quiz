import 'package:flutter/material.dart';
import 'package:devops_quiz/services/user_service.dart';
import 'package:devops_quiz/models/category.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({
    super.key,
    required this.userInfo,
    required this.userService,
    required this.loadData,
    required this.categories,
  });

  final UserInfo userInfo;
  final UserService userService;
  final void Function() loadData;
  final List<Category> categories;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
      height: 137,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('현재 상황',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Row(
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.orange,
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            const Text('초기화 확인'),
                          ],
                        ),
                        content: const Text(
                          '모든 진행 상황이 (체크한 문제 포함) 초기화됩니다.\n계속하시겠습니까?',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              '취소',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            onPressed: () {
                              userService.initUserInfo();
                              Navigator.of(context).pop();
                              loadData();
                            },
                            child: Text(
                              '초기화',
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        actionsPadding:
                            const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 16),
                    const SizedBox(width: 4),
                    Text('초기화',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProgressItemWidget(
                  title: '정확도', value: '${userInfo.correctPercent}%'),
              ProgressItemWidget(
                  title: '푼 문제 수', value: '${userInfo.totalResolvedCount}'),
              ProgressItemWidget(
                  title: '카테고리 수',
                  value:
                      '${categories.where((category) => category.questionCount > 0).length}'),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressItemWidget extends StatelessWidget {
  const ProgressItemWidget(
      {super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: const Color.fromARGB(255, 86, 85, 85))),
      ],
    );
  }
}
