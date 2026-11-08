import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../models/project_model.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  void _showProjectModal(BuildContext context, ProjectItem project) {
    final isMobile = Responsive.isMobile(context);
    final isSmall = Responsive.isSmallMobile(context);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 14 : 20,
          vertical: 24,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720, maxHeight: 750),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.bgDarkSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 28,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.all(isSmall ? 16 : (isMobile ? 20 : 28)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Responsive Modal Header (no overflow)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                color: project.accentColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                project.icon,
                                color: project.accentColor,
                                size: isSmall ? 20 : 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: GoogleFonts.outfit(
                                      fontSize: isSmall ? 18 : 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textWhite,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    project.role,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: project.accentColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: AppColors.textWhite, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Overview
                  Text(
                    'Project Overview',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    project.description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.6,
                      color: AppColors.textBody,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Architecture Banner
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.bgCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: project.accentColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.architecture_rounded,
                          color: project.accentColor,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            project.architecture,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Key Highlights
                  Text(
                    'Engineering Highlights & Implementation',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: project.highlights.map((highlight) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: project.accentColor,
                              size: 15,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                highlight,
                                style: GoogleFonts.inter(
                                  fontSize: 12.5,
                                  height: 1.5,
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

                  // Tech Stack
                  Text(
                    'Technologies Used',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.techStack.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.bgCard,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.glassBorder,
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.firaCode(
                            fontSize: 11,
                            color: project.accentColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : (isSmall ? 16 : 20),
        vertical: isDesktop ? 50 : 30,
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: '03. FEATURED WORK',
            title: 'Highlighted Projects',
            subtitle:
                'Explore applications engineered with clean architecture, responsive Flutter UI, and modern state management.',
          ),
          const SizedBox(height: 28),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < CVData.projects.length; i++) ...[
                      Expanded(
                        child: _ProjectShowcaseCard(
                          project: CVData.projects[i],
                          isReversed: false,
                          forceVertical: true,
                          onViewDetails: () => _showProjectModal(context, CVData.projects[i]),
                        ),
                      ),
                      if (i < CVData.projects.length - 1)
                        const SizedBox(width: 24),
                    ],
                  ],
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: CVData.projects.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final project = CVData.projects[index];
                    return _ProjectShowcaseCard(
                      project: project,
                      isReversed: index % 2 == 1,
                      forceVertical: false,
                      onViewDetails: () => _showProjectModal(context, project),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class _ProjectShowcaseCard extends StatelessWidget {
  final ProjectItem project;
  final bool isReversed;
  final VoidCallback onViewDetails;
  final bool forceVertical;

  const _ProjectShowcaseCard({
    required this.project,
    required this.isReversed,
    required this.onViewDetails,
    this.forceVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = !forceVertical && Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);

    final mockupWidget = _buildDeviceMockup(context, project);
    final detailsWidget = _buildDetailsColumn(context, project);

    return GlassCard(
      glowColor: project.accentColor,
      padding: EdgeInsets.all(isDesktop ? 30 : (isSmall ? 16 : 20)),
      borderRadius: 20,
      child: isDesktop
          ? Row(
              children: isReversed
                  ? [
                      Expanded(flex: 5, child: mockupWidget),
                      const SizedBox(width: 32),
                      Expanded(flex: 6, child: detailsWidget),
                    ]
                  : [
                      Expanded(flex: 6, child: detailsWidget),
                      const SizedBox(width: 32),
                      Expanded(flex: 5, child: mockupWidget),
                    ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                mockupWidget,
                const SizedBox(height: 20),
                detailsWidget,
              ],
            ),
    );
  }

  Widget _buildDeviceMockup(BuildContext context, ProjectItem project) {
    final isDesktop = Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);
    final double mockupHeight = isDesktop ? 300 : (isSmall ? 250 : 275);

    return Container(
      height: mockupHeight,
      decoration: BoxDecoration(
        color: AppColors.bgDarkSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Padding(
          padding: EdgeInsets.all(isSmall ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Device Status Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(project.icon, color: project.accentColor, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        project.title,
                        style: GoogleFonts.outfit(
                          fontSize: isSmall ? 12 : 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textWhite,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.wifi, size: 12, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 12, color: AppColors.textSecondary),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Feature Cards Mockup
              Expanded(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: project.features.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final feat = project.features[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmall ? 8 : 10,
                        vertical: isSmall ? 6 : 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.glassBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: project.accentColor.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              feat.icon,
                              size: 13,
                              color: project.accentColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  feat.title,
                                  style: GoogleFonts.outfit(
                                    fontSize: isSmall ? 11 : 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                Text(
                                  feat.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsColumn(BuildContext context, ProjectItem project) {
    final isDesktop = Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Role & ID Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            color: project.accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: project.accentColor.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            project.role.toUpperCase(),
            style: GoogleFonts.firaCode(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: project.accentColor,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          project.title,
          style: GoogleFonts.outfit(
            fontSize: isDesktop ? 26 : (isSmall ? 20 : 22),
            fontWeight: FontWeight.w800,
            color: AppColors.textWhite,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),

        // Tagline
        Text(
          project.tagLine,
          style: GoogleFonts.inter(
            fontSize: isSmall ? 12.5 : 13.5,
            fontWeight: FontWeight.w600,
            color: project.accentColor,
          ),
        ),
        const SizedBox(height: 10),

        // Description
        Text(
          project.description,
          style: GoogleFonts.inter(
            fontSize: isSmall ? 12.5 : 13.5,
            height: 1.5,
            color: AppColors.textBody,
          ),
        ),
        const SizedBox(height: 14),

        // Tech Stack
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: project.techStack.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.bgDarkSurface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Text(
                tech,
                style: GoogleFonts.firaCode(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),

        // View Details Button — safe against narrow constraints
        _ProjectDetailsButton(
          accentColor: project.accentColor,
          onTap: onViewDetails,
        ),
      ],
    );
  }
}

class _ProjectDetailsButton extends StatefulWidget {
  final Color accentColor;
  final VoidCallback onTap;

  const _ProjectDetailsButton({
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_ProjectDetailsButton> createState() => _ProjectDetailsButtonState();
}

class _ProjectDetailsButtonState extends State<_ProjectDetailsButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.accentColor.withValues(alpha: 0.15)
                : AppColors.bgDarkSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered ? widget.accentColor : AppColors.glassBorder,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  'Explore Architecture',
                  style: GoogleFonts.outfit(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: _isHovered ? widget.accentColor : AppColors.textWhite,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_forward_rounded,
                size: 14,
                color: _isHovered ? widget.accentColor : AppColors.textWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
