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
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750, maxHeight: 800),
          child: GlassCard(
            glowColor: project.accentColor,
            padding: const EdgeInsets.all(32),
            borderRadius: 24,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: project.accentColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              project.icon,
                              color: project.accentColor,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.title,
                                style: GoogleFonts.outfit(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textWhite,
                                ),
                              ),
                              Text(
                                project.role,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: project.accentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Overview
                  Text(
                    'Project Overview',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.7,
                      color: AppColors.textBody,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Architecture Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: project.accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: project.accentColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.architecture_rounded,
                          color: project.accentColor,
                          size: 24,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            project.architecture,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Key Highlights
                  Text(
                    'Engineering Highlights & Implementation',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: project.highlights.map((highlight) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: project.accentColor,
                              size: 18,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                highlight,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
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
                  const SizedBox(height: 24),

                  // Tech Stack
                  Text(
                    'Technologies Used',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.techStack.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E2E33),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.glassBorder,
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.firaCode(
                            fontSize: 12,
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
            tag: ' 03. FEATURED WORK',
            title: 'Highlighted Projects',
            subtitle:
                'Explore applications engineered with clean architecture, responsive Flutter UI, and modern state management.',
          ),
          const SizedBox(height: 36),
          isWide
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
                  separatorBuilder: (context, index) => const SizedBox(height: 30),
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

    final mockupWidget = _buildDeviceMockup(project);
    final detailsWidget = _buildDetailsColumn(context, project);

    return GlassCard(
      glowColor: project.accentColor,
      padding: EdgeInsets.all(isDesktop ? 36 : 22),
      borderRadius: 28,
      child: isDesktop
          ? Row(
              children: isReversed
                  ? [
                      Expanded(flex: 5, child: mockupWidget),
                      const SizedBox(width: 40),
                      Expanded(flex: 6, child: detailsWidget),
                    ]
                  : [
                      Expanded(flex: 6, child: detailsWidget),
                      const SizedBox(width: 40),
                      Expanded(flex: 5, child: mockupWidget),
                    ],
            )
          : Column(
              children: [
                mockupWidget,
                const SizedBox(height: 28),
                detailsWidget,
              ],
            ),
    );
  }

  Widget _buildDeviceMockup(ProjectItem project) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F23).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: project.accentColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: project.accentColor.withValues(alpha: 0.2),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Ambient subtle glow
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: project.accentColor.withValues(alpha: 0.25),
                ),
              ),
            ),

            // Simulated App UI Screen
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Device Status Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(project.icon, color: project.accentColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            project.title,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textWhite,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.wifi, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Icon(Icons.battery_full, size: 14, color: AppColors.textSecondary),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Feature Cards Mockup
                  Expanded(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: project.features.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final feat = project.features[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E2E33).withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.06),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: project.accentColor.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  feat.icon,
                                  size: 16,
                                  color: project.accentColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      feat.title,
                                      style: GoogleFonts.outfit(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textWhite,
                                      ),
                                    ),
                                    Text(
                                      feat.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
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
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsColumn(BuildContext context, ProjectItem project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Role & ID Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: project.accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: project.accentColor.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            project.role.toUpperCase(),
            style: GoogleFonts.firaCode(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: project.accentColor,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Title
        Text(
          project.title,
          style: GoogleFonts.outfit(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: AppColors.textWhite,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),

        // Tagline
        Text(
          project.tagLine,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: project.accentColor,
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          project.description,
          style: GoogleFonts.inter(
            fontSize: 15,
            height: 1.6,
            color: AppColors.textBody,
          ),
        ),
        const SizedBox(height: 20),

        // Tech Stack
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.techStack.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF27272A),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Text(
                tech,
                style: GoogleFonts.firaCode(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 26),

        // View Details Button
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.accentColor.withValues(alpha: 0.2)
                : const Color(0xFF2E2E33).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered ? widget.accentColor : AppColors.glassBorder,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.accentColor.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Explore Deep Architecture',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _isHovered ? widget.accentColor : AppColors.textWhite,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: _isHovered ? widget.accentColor : AppColors.textWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
