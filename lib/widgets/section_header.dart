import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

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
    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Tag Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.cyan.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.cyan.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            tag,
            style: GoogleFonts.firaCode(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.cyan,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Main Title
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.textWhite, Color(0xFFE2E8F0)],
          ).createShader(bounds),
          child: Text(
            title,
            textAlign: isCenter ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.outfit(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: Colors.white,
            ),
          ),
        ),

        // Subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              subtitle!,
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
              style: GoogleFonts.inter(
                fontSize: 16,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
        const SizedBox(height: 36),
      ],
    );
  }
}
