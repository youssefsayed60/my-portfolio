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

  const SkillItem({
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    this.tags = const [],
  });
}
