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
    final isWide = isDesktop || isTablet;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: ' 01. CAREER PATH',
            title: 'Professional Experience',
            subtitle:
                'Hands-on journey building high-performance mobile applications and crafting scalable architectures at NTG Clarity.',
          ),
          const SizedBox(height: 36),
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
                        const SizedBox(height: 20),
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

  Widget _buildIconBadge(Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: isFirst
            ? AppColors.primaryGradient
            : AppColors.babyBlueGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.35),
            blurRadius: 16,
          ),
        ],
      ),
      child: const Icon(
        Icons.business_center_rounded,
        color: Color(0xFFF4F4F5),
        size: 24,
      ),
    );
  }

  Widget _buildTitleColumn(Color accentColor, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              experience.role,
              style: GoogleFonts.outfit(
                fontSize: isDesktop ? 22 : 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textWhite,
              ),
            ),
            if (experience.isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.emerald,
                    width: 1,
                  ),
                ),
                child: Text(
                  'CURRENT ROLE',
                  style: GoogleFonts.firaCode(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.emerald,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          experience.company,
          style: GoogleFonts.inter(
            fontSize: 16,
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
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E33).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.glassBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 13,
            color: AppColors.cyan,
          ),
          const SizedBox(width: 6),
          Text(
            experience.period,
            style: GoogleFonts.firaCode(
              fontSize: 12,
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
    final accentColor = isFirst ? AppColors.cyan : AppColors.babyBlue;

    return GlassCard(
      glowColor: accentColor,
      padding: EdgeInsets.all(isDesktop ? 32 : 20),
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Role, Period, Company
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIconBadge(accentColor),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTitleColumn(accentColor, isDesktop)),
                    const SizedBox(width: 16),
                    _buildDatePill(),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIconBadge(accentColor),
                        const SizedBox(width: 14),
                        Expanded(child: _buildTitleColumn(accentColor, isDesktop)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _buildDatePill(),
                    ),
                  ],
                ),
          const SizedBox(height: 20),

          // Divider
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.08),
          ),
          const SizedBox(height: 20),

          // Bullet Points
          Column(
            children: experience.bulletPoints.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withValues(alpha: 0.6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        point,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          height: 1.6,
                          color: AppColors.textBody,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Tech Stack Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experience.techStack.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  tech,
                  style: GoogleFonts.firaCode(
                    fontSize: 12,
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
