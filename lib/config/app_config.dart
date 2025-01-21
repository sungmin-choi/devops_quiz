class AppConfig {
  static const String baseUrl = 'http://192.168.0.19:3000'; // 개발 환경
  // static const String baseUrl = 'https://api.yourapp.com';  // 프로덕션 환경

  // 다른 글로벌 설정값들도 여기에 추가
  static const int connectionTimeout = 30000; // 30초
  static const int receiveTimeout = 30000; // 30초

  // 환경별 설정을 위한 enum
  static const Environment environment = Environment.development;
}

enum Environment { development, staging, production }
