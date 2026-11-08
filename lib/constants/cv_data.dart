import 'package:flutter/material.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class CVData {
  static const String name = 'Youssef Sayed';
  static const String title = 'Flutter Developer';
  static const String experienceYears = '3+';
  static const String email = 'youseefsayed60@gmail.com';
  static const String phone = '01094348682';
  static const String internationalPhone = '+201094348682';
  static const String linkedIn = 'https://www.linkedin.com/in/youssef-sayed-395812445';
  static const String github = 'https://github.com';
  static const String profileImage = 'assets/images/profile.jpg';

  static const String bio =
      'Flutter developer with 3 years of hands-on experience in building cross-platform '
      'mobile applications, Skilled in creating '
      'responsive, high-performance apps with clean architecture and intuitive UI/UX design. '
      'Passionate about delivering efficient, user-centered mobile solutions and continuously '
      'improving through learning and innovation.';

  static const List<String> typewriterTitles = [
    'Flutter Developer',
    'Mobile Application Engineer',
    'Clean Architecture Specialist',
    'BLoC & State Management Expert',
    'UI/UX Craftsman for Web & Mobile',
  ];

  static const List<Map<String, String>> quickStats = [
    {'value': '3+', 'label': 'Years Experience'},
    {'value': '2+', 'label': 'Flagship Mobile Apps'},
    {'value': '15+', 'label': 'Technologies Mastered'},
    {'value': '100%', 'label': 'Clean Architecture'},
  ];

  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      role: 'Flutter Developer',
      company: 'NTG Clarity',
      period: '09/2025 - Present',
      duration: 'Ongoing',
      isCurrent: true,
      bulletPoints: [
        'Developing production-ready cross-platform mobile solutions using Flutter & Dart.',
        'Architecting scalable, modular codebases adhering strictly to Clean Architecture and MVVM patterns.',
        'Integrating intricate RESTful APIs, caching strategies, and secure persistent local storage.',
        'Delivering responsive, pixel-perfect user interfaces with custom widgets and fluid animations for diverse screen form factors.',
        'Ensuring robust code quality through comprehensive state management with BLoC and Cubit.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'BLoC',
        'Cubit',
        'Clean Architecture',
        'REST APIs',
        'Git',
      ],
    ),
    ExperienceItem(
      role: 'Flutter Developer Intern',
      company: 'NTG Clarity',
      period: '09/2024 - 09/2025',
      duration: '1 Year',
      isCurrent: false,
      bulletPoints: [
        'Collaborated on engineering mobile applications using Flutter & Dart from concept to deployment.',
        'Integrated Firebase services including Authentication, Cloud Firestore, Realtime Database, and FCM push notifications.',
        'Built smooth user journeys through advanced state management patterns (Provider, BLoC, Cubit).',
        'Conducted emulator and physical device debugging, performance profiling, and git version control workflows.',
        'Implemented background local notifications and responsive layouts compatible with multiple screen densities.',
      ],
      techStack: [
        'Flutter',
        'Firebase',
        'Provider',
        'BLoC',
        'FCM',
        'REST APIs',
        'Android Studio',
      ],
    ),
  ];

  static const List<SkillItem> skills = [
    // Mobile Development
    SkillItem(
      name: 'Flutter & Dart',
      description: 'Custom widgets, responsive layouts, high frame-rate animations, and platform channels.',
      icon: Icons.flutter_dash,
      category: SkillCategory.mobile,
      tags: ['Flutter', 'Dart', 'Web & Mobile', 'Animations'],
      url: 'https://flutter.dev',
    ),
    SkillItem(
      name: 'Advanced State Management',
      description: 'Predictable state patterns using BLoC, Cubit, and Provider with decoupled business logic.',
      icon: Icons.account_tree_outlined,
      category: SkillCategory.mobile,
      tags: ['Bloc', 'Cubit', 'Provider', 'RiverPod'],
      url: 'https://bloclibrary.dev',
    ),
    SkillItem(
      name: 'Firebase Ecosystem',
      description: 'End-to-end cloud backends: Auth, Firestore, Realtime DB, Cloud Messaging (FCM).',
      icon: Icons.local_fire_department,
      category: SkillCategory.mobile,
      tags: ['Authentication', 'Firestore', 'Realtime DB', 'FCM', 'Storage'],
      url: 'https://firebase.google.com',
    ),
    SkillItem(
      name: 'Push & Local Notifications',
      description: 'Background handling, foreground display, actionable notification triggers, FCM payloads.',
      icon: Icons.notifications_active_outlined,
      category: SkillCategory.mobile,
      tags: ['Firebase FCM', 'Local Notifications', 'Background Tasks', 'Deep Linking'],
      url: 'https://firebase.google.com/docs/cloud-messaging',
    ),
    SkillItem(
      name: 'Clean Architecture & MVVM',
      description: 'Domain-driven separation: Presentation, Domain, Data layers, Dependency Injection, Repositories.',
      icon: Icons.layers_outlined,
      category: SkillCategory.architectureAndTools,
      tags: ['Clean Architecture', 'MVVM', 'MVC', 'Repository Pattern', 'OOP Principles'],
      url: 'https://www.google.com/search?q=Flutter+Clean+Architecture+MVVM',
    ),
    SkillItem(
      name: 'RESTful API Integration',
      description: 'HTTP client orchestration, interceptors, JSON serialization, error handling, token refresh.',
      icon: Icons.http_outlined,
      category: SkillCategory.architectureAndTools,
      tags: ['Dio', 'HTTP', 'JSON Serialization', 'JWT Auth', 'WebSockets'],
      url: 'https://pub.dev/packages/dio',
    ),

    // Database Development
    SkillItem(
      name: 'SQL & PL/SQL',
      description: 'Schema design, complex queries, indexing, joins, transactions, and stored procedures.',
      icon: Icons.storage_outlined,
      category: SkillCategory.database,
      tags: ['SQL', 'PL/SQL', 'Relational DB', 'Queries', 'Optimization'],
      url: 'https://www.google.com/search?q=SQL+and+PL+SQL+Database',
    ),
    SkillItem(
      name: 'Relational Database Design',
      description: 'Entity-relationship modeling, normalization, foreign key constraints, data integrity.',
      icon: Icons.table_chart_outlined,
      category: SkillCategory.database,
      tags: ['Normalization', 'ERD', 'PostgreSQL', 'MySQL', 'SQLite'],
      url: 'https://www.google.com/search?q=Relational+Database+Design+Principles',
    ),

    // Other Programming Skills
    SkillItem(
      name: 'Java & Spring Boot',
      description: 'Backend microservices, REST controllers, Spring Framework, OOP patterns.',
      icon: Icons.coffee,
      category: SkillCategory.programming,
      tags: ['Java', 'Spring Framework', 'Spring Boot', 'REST APIs'],
      url: 'https://spring.io/projects/spring-boot',
    ),
    SkillItem(
      name: 'Python & Flask',
      description: 'Rapid prototyping, backend REST API services, scripting, and data pipelines.',
      icon: Icons.terminal_outlined,
      category: SkillCategory.programming,
      tags: ['Python 3', 'Flask', 'Automation', 'Scripting'],
      url: 'https://flask.palletsprojects.com',
    ),
    SkillItem(
      name: 'TypeScript & JavaScript',
      description: 'Modern ES6+ frontend development, asynchronous patterns, and web tooling.',
      icon: Icons.javascript_outlined,
      category: SkillCategory.programming,
      tags: ['TypeScript', 'JavaScript', 'ES6+', 'Async/Await'],
      url: 'https://www.typescriptlang.org',
    ),
    SkillItem(
      name: 'Angular & Frontend',
      description: 'Component architecture, single-page web applications, TypeScript interfaces.',
      icon: Icons.web,
      category: SkillCategory.programming,
      tags: ['Angular', 'SPA', 'Components', 'RxJS'],
      url: 'https://angular.dev',
    ),
    SkillItem(
      name: 'C++ & Core OOP',
      description: 'Strong foundation in low-level memory concepts, data structures, and algorithms.',
      icon: Icons.memory_outlined,
      category: SkillCategory.programming,
      tags: ['C++', 'OOP', 'Data Structures', 'Algorithms'],
      url: 'https://isocpp.org',
    ),
    SkillItem(
      name: 'Oracle APEX',
      description: 'Enterprise database application builder, SQL rapid development.',
      icon: Icons.cloud_done_outlined,
      category: SkillCategory.programming,
      tags: ['Oracle APEX', 'PL/SQL', 'Enterprise Apps'],
      url: 'https://apex.oracle.com',
    ),

    // Tools & Platform
    SkillItem(
      name: 'Tools & Version Control',
      description: 'Android Studio, VS Code, Git & GitHub, Firebase Console, Emulator & real-device debugging.',
      icon: Icons.alt_route_rounded,
      category: SkillCategory.architectureAndTools,
      tags: ['Android Studio', 'VS Code', 'Git', 'GitHub', 'Firebase Console', 'Debugging'],
      url: 'https://git-scm.com',
    ),

    // Soft Skills
    SkillItem(
      name: 'Problem Solving & Growth Mindset',
      description: 'Analytical troubleshooting, fast learner, rapid adaptability to new tech stacks & deadlines.',
      icon: Icons.psychology_outlined,
      category: SkillCategory.softSkills,
      tags: ['Analytical Thinking', 'Fast Learner', 'Adaptability', 'Time Management', 'Teamwork'],
      url: 'https://www.google.com/search?q=Problem+Solving+and+Growth+Mindset+Software+Engineering',
    ),
  ];

  static const List<ProjectItem> projects = [
    ProjectItem(
      id: 'swapskill',
      title: 'SwapSkill',
      tagLine: 'Interactive Peer-to-Peer Skill Exchange & Gamified Learning Platform',
      description:
          'A cross-platform mobile application designed to facilitate seamless skill exchange among users. '
          'Allows each user to showcase their unique skills, barter knowledge, and learn new skills from '
          'peers through an interactive, gamified system of challenges, skill quizzes with AI-Model, and achievement milestones.',
      techStack: [
        'Flutter',
        'Dart',
        'BLoC',
        'Firebase Firestore',
        'Firebase Auth',
        'Cloud Messaging (FCM)',
        'Postgres Database Hosted',
        'AI Model',
        'RESTful APIs',
        'Clean Architecture',
      ],
      features: [
        ProjectFeature(
          title: 'Skill Showcase & Barter',
          description: 'Users create dynamic skill cards to exchange mentorship without currency.',
          icon: Icons.swap_horiz_rounded,
        ),
        ProjectFeature(
          title: 'Gamified Quizzes & Challenges',
          description: 'Interactive AI test modules to validate skills and earn verified peer badges.',
          icon: Icons.emoji_events_outlined,
        ),
        ProjectFeature(
          title: 'Real-time Push Notifications',
          description: 'FCM powered alerts for challenge invitations, messages, and progress.',
          icon: Icons.notifications_active_outlined,
        ),
        ProjectFeature(
          title: 'Clean Architecture State',
          description: 'BLoC pattern separating business logic, state streams, and UI layer.',
          icon: Icons.architecture_rounded,
        ),
      ],
      architecture: 'Clean Architecture with BLoC State Management & Firebase Cloud backend.',
      accentColor: Color(0xFF6366F1),
      icon: Icons.all_inclusive_rounded,
      role: 'Lead Mobile Developer',
      highlights: [
        'Engineered responsive quiz interface with animated countdown timers and instant feedback.',
        'Implemented Firestore reactive streams for real-time barter proposals and live status updates.',
        'Optimized custom UI components ensuring 60 FPS fluid rendering on budget devices.',
      ],
    ),
    ProjectItem(
      id: 'hireme',
      title: 'Hire Me',
      tagLine: 'Next-Gen Mobile Recruitment & Career Opportunity Matcher',
      description:
          'A modern mobile application bridging the gap between job seekers and potential employers. '
          'Enables job seekers to build professional interactive portfolios, showcase verified skills, '
          'and apply for opportunities in 1 tap. Simultaneously empowers employers to post openings, '
          'filter candidate pools, and streamline the hiring workflow via an intuitive, elegant dashboard.',
      techStack: [
        'Flutter',
        'Dart',
        'Provider / Cubit',
        'RESTful APIs',
        'Firebase Auth',
        'Push Notifications',
        'Responsive UI',
        'Clean Architecture',
      ],
      features: [
        ProjectFeature(
          title: 'Dynamic Profile Builder',
          description: 'Job seekers build rich digital CVs with skills, portfolios, and experience cards.',
          icon: Icons.badge_outlined,
        ),
        ProjectFeature(
          title: 'Employer Recruitment Hub',
          description: 'Post job openings, review applicants with filtering, and update status seamlessly.',
          icon: Icons.business_center_outlined,
        ),
        ProjectFeature(
          title: '1-Tap Application & Tracking',
          description: 'Instant job submission and real-time status tracker (Applied, Review, Interview).',
          icon: Icons.touch_app_outlined,
        ),
        ProjectFeature(
          title: 'Smart Search & Filter',
          description: 'Search vacancies by role, stack, seniority, or remote flexibility.',
          icon: Icons.filter_list_rounded,
        ),
      ],
      architecture: 'MVVM Clean Architecture with RESTful Services and Local Caching.',
      accentColor: Color(0xFF818CF8),
      icon: Icons.work_outline_rounded,
      role: 'Mobile Application Architect',
      highlights: [
        'Designed dual-persona experience for both Candidates and Hiring Managers.',
        'Integrated RESTful APIs with secure token refresh and offline profile draft support.',
        'Crafted smooth micro-animations for swipeable candidate cards and status transitions.',
      ],
    ),
  ];
}

