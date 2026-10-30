import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../models/skill_model.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/section_header.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  SkillCategory? _selectedCategory;

  final Map<SkillCategory?, String> _categories = {
    null: 'All Skills',
    SkillCategory.mobile: 'Mobile & Flutter',
    SkillCategory.architectureAndTools: 'Architecture & Tools',
    SkillCategory.database: 'Databases',
    SkillCategory.programming: 'Other Languages',
    SkillCategory.softSkills: 'Soft Skills',
  };

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final filteredSkills = _selectedCategory == null
        ? CVData.skills
        : CVData.skills
            .where((s) => s.category == _selectedCategory)
            .toList();

    int crossAxisCount = isDesktop ? 4 : (isTablet ? 3 : 2);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: ' 02. TECHNICAL ARSENAL',
            title: 'Skills & Capabilities',
            subtitle:
                'A battle-tested set of skills honed over 3+ years of architecting scalable Flutter apps, backends, and databases.',
          ),

          // Category Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _categories.entries.map((entry) {
                final isSelected = _selectedCategory == entry.key;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = entry.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.primaryGradient : null,
                        color: isSelected
                            ? null
                            : const Color(0xFF27272A).withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : AppColors.glassBorder,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.cyan.withValues(alpha: 0.35),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        entry.value,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFFF4F4F5)
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 36),

          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final double itemWidth =
                  (constraints.maxWidth - ((crossAxisCount - 1) * 16)) /
                      crossAxisCount;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: filteredSkills.map((skill) {
                  return SizedBox(
                    width: itemWidth,
                    child: _SkillCard(skill: skill),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final SkillItem skill;

  const _SkillCard({required this.skill});

  Color _getCategoryColor(SkillCategory cat) {
    switch (cat) {
      case SkillCategory.mobile:
        return AppColors.cyan;
      case SkillCategory.architectureAndTools:
        return AppColors.purple;
      case SkillCategory.database:
        return AppColors.amber;
      case SkillCategory.programming:
        return AppColors.blue;
      case SkillCategory.softSkills:
        return AppColors.emerald;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _getCategoryColor(skill.category);

    return GlassCard(
      glowColor: accent,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      borderRadius: 14,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: accent.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(skill.icon, color: accent, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              skill.name,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textWhite,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
