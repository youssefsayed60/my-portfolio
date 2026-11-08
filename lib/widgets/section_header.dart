import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'responsive_builder.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final bool isCenter;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = Responsive.isSmallMobile(context);
    final isMobile = Responsive.isMobile(context);

    final double titleFontSize = isSmall ? 22 : (isMobile ? 26 : 34);
    final double subtitleFontSize = isSmall ? 13 : (isMobile ? 14 : 15);

    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Tag Pill — restrained, clean accent
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 10 : 14,
            vertical: isSmall ? 4 : 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.cyan.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.cyan.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Text(
            tag,
            style: GoogleFonts.firaCode(
              fontSize: isSmall ? 11 : 12,
              fontWeight: FontWeight.w600,
              color: AppColors.cyan,
              letterSpacing: 1.1,
            ),
          ),
        ),
        SizedBox(height: isSmall ? 10 : 14),

        // Main Title — responsive sizing
        Text(
          title,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.outfit(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: AppColors.textWhite,
          ),
        ),

        // Subtitle — readable slate
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
              style: GoogleFonts.inter(
                fontSize: subtitleFontSize,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
        SizedBox(height: isMobile ? 24 : 36),
      ],
    );
  }
}
