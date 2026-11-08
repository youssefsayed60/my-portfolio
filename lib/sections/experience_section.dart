import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../models/experience_model.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final isSmall = Responsive.isSmallMobile(context);
    final isWide = isDesktop || isTablet;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : (isSmall ? 16 : 20),
        vertical: isDesktop ? 50 : 30,
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: '01. CAREER PATH',
            title: 'Professional Experience',
            subtitle:
                'Hands-on journey building high-performance mobile applications and crafting scalable architectures at NTG Clarity.',
          ),
          const SizedBox(height: 28),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < CVData.experiences.length; i++) ...[
                      Expanded(
                        child: _ExperienceCard(
                          experience: CVData.experiences[i],
                          isFirst: i == 0,
                        ),
                      ),
                      if (i < CVData.experiences.length - 1)
                        const SizedBox(width: 24),
                    ],
                  ],
                )
              : Column(
                  children: [
                    for (int i = 0; i < CVData.experiences.length; i++) ...[
                      _ExperienceCard(
                        experience: CVData.experiences[i],
                        isFirst: i == 0,
                      ),
                      if (i < CVData.experiences.length - 1)
                        const SizedBox(height: 18),
                    ],
                  ],
                ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceItem experience;
  final bool isFirst;

  const _ExperienceCard({
    required this.experience,
    required this.isFirst,
  });

  Widget _buildIconBadge(Color accentColor, bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 9 : 11),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.25),
        ),
      ),
      child: Icon(
        Icons.business_center_rounded,
        color: accentColor,
        size: isSmall ? 18 : 20,
      ),
    );
  }

  Widget _buildTitleColumn(Color accentColor, bool isDesktop, bool isSmall) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              experience.role,
              style: GoogleFonts.outfit(
                fontSize: isDesktop ? 20 : (isSmall ? 16 : 17),
                fontWeight: FontWeight.w800,
                color: AppColors.textWhite,
              ),
            ),
            if (experience.isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.emerald.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Text(
                  'CURRENT ROLE',
                  style: GoogleFonts.firaCode(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.emerald,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          experience.company,
          style: GoogleFonts.inter(
            fontSize: isSmall ? 13 : 14.5,
            fontWeight: FontWeight.w600,
            color: accentColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePill() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgDarkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.glassBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.calendar_today_rounded,
            size: 11,
            color: AppColors.cyan,
          ),
          const SizedBox(width: 5),
          Text(
            experience.period,
            style: GoogleFonts.firaCode(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);
    final accentColor = isFirst ? AppColors.cyan : AppColors.blue;

    return GlassCard(
      glowColor: accentColor,
      padding: EdgeInsets.all(isDesktop ? 28 : (isSmall ? 16 : 20)),
      borderRadius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Role, Period, Company
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIconBadge(accentColor, isSmall),
                    const SizedBox(width: 14),
                    Expanded(child: _buildTitleColumn(accentColor, isDesktop, isSmall)),
                    const SizedBox(width: 14),
                    _buildDatePill(),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIconBadge(accentColor, isSmall),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTitleColumn(accentColor, isDesktop, isSmall)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _buildDatePill(),
                    ),
                  ],
                ),
          const SizedBox(height: 16),

          // Divider
          Container(
            height: 1,
            color: AppColors.glassBorder,
          ),
          const SizedBox(height: 16),

          // Bullet Points
          for (final point in experience.bulletPoints)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      point,
                      style: GoogleFonts.inter(
                        fontSize: isSmall ? 12.5 : 13.5,
                        height: 1.55,
                        color: AppColors.textBody,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),

          // Tech Stack Chips
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: experience.techStack.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.glassBorder,
                  ),
                ),
                child: Text(
                  tech,
                  style: GoogleFonts.firaCode(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textWhite,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
