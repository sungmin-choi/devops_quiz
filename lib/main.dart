import 'package:flutter/material.dart';
import 'package:devops_quiz/screens/categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'DevOps Quiz App',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: const Color.fromARGB(46, 74, 145, 226), // 메인 컬러
            surface: const Color(0xFFF3F4F6), // 배경색
            secondary: const Color(0xFFFFB74D), // 포인트 컬러
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // 배경색 설정
          scaffoldBackgroundColor: const Color(0xFFF3F4F6),
          // 폰트 설정
          fontFamily: 'Roboto',
          // Material 3 디자인 사용
          useMaterial3: true,
          // 앱바 테마 설정
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(241, 9, 9, 10),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: CategoriesScreen(),
      ),
    );
  }
}
