import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevOps Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF4A90E2), // 메인 컬러
          surface: const Color(0xFFF9FBFD), // 배경색
          secondary: const Color(0xFFFFB74D), // 포인트 컬러
        ),
        // 배경색 설정
        scaffoldBackgroundColor: const Color(0xFFF9FBFD),
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
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'DevOps Quiz App',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        body: Center(
          child: Text('DevOps Quiz App'),
        ),
      ),
    );
  }
}
