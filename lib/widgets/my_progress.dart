import 'package:flutter/material.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});

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
      height: 130,
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
              Row(
                children: [
                  Icon(Icons.settings, size: 16),
                  const SizedBox(width: 4),
                  Text('초기화',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProgressItemWidget(title: '정확도', value: '85%'),
              ProgressItemWidget(title: '푼 문제 수', value: '247'),
              ProgressItemWidget(title: '카테고리 수', value: '18'),
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
