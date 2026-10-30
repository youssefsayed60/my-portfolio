import 'package:flutter/material.dart';

class ProjectFeature {
  final String title;
  final String description;
  final IconData icon;

  const ProjectFeature({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ProjectItem {
  final String id;
  final String title;
  final String tagLine;
  final String description;
  final List<String> techStack;
  final List<ProjectFeature> features;
  final String architecture;
  final Color accentColor;
  final IconData icon;
  final String role;
  final List<String> highlights;

  const ProjectItem({
    required this.id,
    required this.title,
    required this.tagLine,
    required this.description,
    required this.techStack,
    required this.features,
    required this.architecture,
    required this.accentColor,
    required this.icon,
    required this.role,
    required this.highlights,
  });
}
