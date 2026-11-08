import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
    final isSmall = Responsive.isSmallMobile(context);

    final filteredSkills = _selectedCategory == null
        ? CVData.skills
        : CVData.skills
            .where((s) => s.category == _selectedCategory)
            .toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : (isSmall ? 16 : 20),
        vertical: isDesktop ? 50 : 30,
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: '02. TECHNICAL ARSENAL',
            title: 'Skills & Capabilities',
            subtitle:
                'A battle-tested set of skills honed over 3+ years of architecting scalable Flutter apps, backends, and databases.',
          ),

          // Category Filter Tabs — smooth horizontal swipe on mobile, centered on desktop
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 4),
              child: Row(
                mainAxisAlignment:
                    isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: _categories.entries.map((entry) {
                  final isSelected = _selectedCategory == entry.key;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = entry.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmall ? 12 : 16,
                          vertical: isSmall ? 6 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.cyan.withValues(alpha: 0.15)
                              : AppColors.bgCard,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.cyan.withValues(alpha: 0.5)
                                : AppColors.glassBorder,
                          ),
                        ),
                        child: Text(
                          entry.value,
                          style: GoogleFonts.outfit(
                            fontSize: isSmall ? 12 : 13,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? AppColors.textWhite
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Responsive Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              int crossAxisCount;
              double spacing;

              if (width >= 1050) {
                crossAxisCount = 4;
                spacing = 14;
              } else if (width >= 680) {
                crossAxisCount = 3;
                spacing = 12;
              } else if (width >= 350) {
                crossAxisCount = 2;
                spacing = 10;
              } else {
                crossAxisCount = 1;
                spacing = 8;
              }

              final double itemWidth =
                  (width - ((crossAxisCount - 1) * spacing)) / crossAxisCount;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: filteredSkills.map((skill) {
                  return SizedBox(
                    width: itemWidth,
                    child: _SkillCard(
                      skill: skill,
                      isCompact: crossAxisCount == 2 && width < 480,
                    ),
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
  final bool isCompact;

  const _SkillCard({
    required this.skill,
    this.isCompact = false,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Color _getCategoryColor(SkillCategory cat) {
    switch (cat) {
      case SkillCategory.mobile:
        return AppColors.cyan;
      case SkillCategory.architectureAndTools:
        return AppColors.blue;
      case SkillCategory.database:
        return AppColors.babyBlue;
      case SkillCategory.programming:
        return AppColors.violet;
      case SkillCategory.softSkills:
        return AppColors.emerald;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _getCategoryColor(skill.category);
    final isOfficial = skill.url != null && !skill.url!.contains('google.com');

    return Tooltip(
      message: isOfficial
          ? 'Explore official website for ${skill.name}'
          : 'Search Google for ${skill.name}',
      waitDuration: const Duration(milliseconds: 400),
      child: GlassCard(
        glowColor: accent,
        height: isCompact ? 56 : 52,
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 8 : 12,
          vertical: 8,
        ),
        borderRadius: 12,
        onTap: () => _launchUrl(skill.targetUrl),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: accent.withValues(alpha: 0.25),
                ),
              ),
              child: Icon(skill.icon, color: accent, size: isCompact ? 15 : 16),
            ),
            SizedBox(width: isCompact ? 8 : 10),
            Expanded(
              child: Text(
                skill.name,
                style: GoogleFonts.outfit(
                  fontSize: isCompact ? 11.5 : 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                  height: 1.25,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_outward_rounded,
              size: isCompact ? 11 : 12,
              color: AppColors.textMuted.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
