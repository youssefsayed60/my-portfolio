import 'package:flutter/material.dart';

enum SkillCategory {
  mobile,
  database,
  programming,
  architectureAndTools,
  softSkills,
}

class SkillItem {
  final String name;
  final String description;
  final IconData icon;
  final SkillCategory category;
  final List<String> tags;
  final String? url;

  const SkillItem({
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    this.tags = const [],
    this.url,
  });

  /// Target URL to open: official website if provided, or Google search query.
  String get targetUrl {
    if (url != null && url!.trim().isNotEmpty) {
      return url!;
    }
    return 'https://www.google.com/search?q=${Uri.encodeComponent(name)}';
  }
}
