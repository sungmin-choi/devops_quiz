import 'package:flutter_riverpod/flutter_riverpod.dart';

// 현재 선택된 답변을 관리하는 Provider
final currentAnswerProvider = StateProvider<dynamic>((ref) => null);
