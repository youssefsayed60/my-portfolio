class ExperienceItem {
  final String role;
  final String company;
  final String period;
  final String duration;
  final List<String> bulletPoints;
  final List<String> techStack;
  final bool isCurrent;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.duration,
    required this.bulletPoints,
    required this.techStack,
    this.isCurrent = false,
  });
}
