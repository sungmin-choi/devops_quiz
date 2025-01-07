import 'package:devops_quiz/models/question.dart';
import 'package:devops_quiz/models/category.dart';

final List<Question> dummyQuestions = [
  // Kubernetes 문제
  Question(
    questionId: 'q002',
    category: QuestionCategory.kubernetes,
    questionType: QuestionType.multipleChoice,
    difficulty: QuestionDifficulty.medium,
    questionText: 'Kubernetes의 주요 컴포넌트가 아닌 것을 모두 고르시오.',
    options: [
      'Pod',
      'Docker Swarm',
      'Jenkins Pipeline',
      'Apache Mesos',
      'Service',
      'Deployment'
    ],
    answer: [1, 2, 3],
    explanationText: 'Pod, Service, Deployment는 Kubernetes의 기본 컴포넌트입니다.',
  ),

  // Docker 문제
  Question(
    questionId: 'q003',
    category: QuestionCategory.docker,
    questionType: QuestionType.trueFalse,
    difficulty: QuestionDifficulty.easy,
    questionText: 'Docker 컨테이너는 호스트 OS의 커널을 공유한다.',
    answer: true,
    explanationText: 'Docker 컨테이너는 호스트 OS의 커널을 공유하여 가볍고 빠른 실행이 가능합니다.',
  ),

  // Git 문제
  Question(
    questionId: 'q004',
    category: QuestionCategory.git,
    questionType: QuestionType.fillInTheBlank,
    difficulty: QuestionDifficulty.medium,
    questionText: 'Git에서 원격 저장소의 변경사항을 로컬로 가져오는 명령어는 "git ___" 입니다.',
    answer: 'pull',
    explanationText: 'git pull 명령어는 원격 저장소의 변경사항을 로컬 저장소로 가져와 병합합니다.',
  ),

  // CI/CD 문제
  Question(
    questionId: 'q005',
    category: QuestionCategory.ciCd,
    questionType: QuestionType.singleChoice,
    difficulty: QuestionDifficulty.hard,
    questionText: '다음 중 CI(Continuous Integration)의 핵심 실천 사항이 아닌 것은?',
    options: ['자동화된 빌드', '자동화된 테스트', '수동 코드 리뷰', '버전 관리'],
    answer: 2,
    explanationText: 'CI는 자동화에 중점을 둡니다. 수동 코드 리뷰는 중요하지만 CI의 핵심 자동화 과정은 아닙니다.',
  ),

  // Linux 문제
  Question(
    questionId: 'q006',
    category: QuestionCategory.linux,
    questionType: QuestionType.multipleChoice,
    difficulty: QuestionDifficulty.medium,
    questionText: '다음 중 리눅스 파일 권한을 변경하는 명령어를 모두 고르시오.',
    options: ['chmod', 'chown', 'mv', 'cp', 'ls'],
    answer: [0, 1],
    explanationText: 'chmod는 파일의 권한을, chown은 파일의 소유자를 변경하는 명령어입니다.',
  ),

  // Jenkins 문제
  Question(
    questionId: 'q009',
    category: QuestionCategory.jenkins,
    questionType: QuestionType.fillInTheBlank,
    difficulty: QuestionDifficulty.medium,
    questionText: 'Jenkins에서 파이프라인을 정의하는 파일의 이름은 "_____" 입니다.',
    answer: 'Jenkinsfile',
    explanationText: 'Jenkinsfile은 Jenkins 파이프라인의 구성을 코드로 정의하는 파일입니다.',
  ),

  Question(
    questionId: 'q012',
    category: QuestionCategory.ansible,
    questionType: QuestionType.singleChoice,
    difficulty: QuestionDifficulty.medium,
    questionText: 'Ansible 플레이북의 파일 형식은?',
    options: ['YAML', 'JSON', 'XML', 'INI'],
    answer: 0,
    explanationText: 'Ansible 플레이북은 YAML 형식으로 작성됩니다.',
  ),

  // 이미지가 포함된 문제
  Question(
    questionId: 'q013',
    category: QuestionCategory.docker,
    questionType: QuestionType.singleChoice,
    difficulty: QuestionDifficulty.medium,
    questionText: '다음 Docker 아키텍처 다이어그램에서 잘못된 부분을 고르시오.',
    imageUrl: 'assets/images/docker_architecture.png',
    options: ['Container', 'Docker Daemon', 'Registry', 'REST API'],
    answer: 3,
    explanationText: 'Docker 아키텍처의 기본 구성요소는 정확하게 표현되어 있습니다.',
  ),

  // Kubernetes 고급 문제
  Question(
    questionId: 'q015',
    category: QuestionCategory.kubernetes,
    questionType: QuestionType.fillInTheBlank,
    difficulty: QuestionDifficulty.hard,
    questionText:
        'Kubernetes에서 파드의 자동 확장을 담당하는 리소스의 이름은 "Horizontal Pod _____" 입니다.',
    answer: 'Autoscaler',
    explanationText:
        'HPA(Horizontal Pod Autoscaler)는 워크로드의 CPU 또는 메모리 사용량에 따라 파드의 개수를 자동으로 조절합니다.',
  ),
];

final List<Category> categories = [
  Category(
      category: QuestionCategory.docker,
      title: 'Docker',
      subtitle: '컨테이너 플랫폼 및 도구',
      imageUrl: 'assets/icons/docker.svg',
      questionCount: 100),
  Category(
      category: QuestionCategory.kubernetes,
      title: 'Kubernetes',
      subtitle: '컨테이너 오케스트레이션',
      imageUrl: 'assets/icons/kubernetes.svg',
      questionCount: 120),
  Category(
      category: QuestionCategory.linux,
      title: 'Linux',
      subtitle: '운영체제 기초',
      imageUrl: 'assets/icons/linux.svg',
      questionCount: 100),
  Category(
      category: QuestionCategory.networking,
      title: 'Networking',
      subtitle: '네트워크 프로토콜 및 보안',
      imageUrl: 'assets/icons/networking.svg',
      questionCount: 100),
  Category(
      category: QuestionCategory.git,
      title: 'Git',
      subtitle: '버전 관리 시스템',
      imageUrl: 'assets/icons/git.svg',
      questionCount: 100),
  Category(
      category: QuestionCategory.jenkins,
      title: 'Jenkins',
      subtitle: 'CI/CD 도구',
      imageUrl: 'assets/icons/jenkins.svg',
      questionCount: 100),
  Category(
      category: QuestionCategory.ansible,
      title: 'Ansible',
      subtitle: '구성 관리 도구',
      imageUrl: 'assets/icons/ansible.svg',
      questionCount: 100),
  Category(
      category: QuestionCategory.cs,
      title: 'CS',
      subtitle: '컴퓨터 공학 기초',
      imageUrl: 'assets/icons/cs.svg',
      questionCount: 100),
];
