import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../widgets/responsive_builder.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onBackToTop;

  const FooterSection({super.key, required this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : (isSmall ? 16 : 20),
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgDarkSurface,
        border: Border(
          top: BorderSide(
            color: AppColors.glassBorder,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo & Title (overflow-safe)
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cyan.withValues(alpha: 0.15),
                        border: Border.all(
                          color: AppColors.cyan.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.flutter_dash,
                        color: AppColors.cyan,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${CVData.name} • Flutter Developer',
                        style: GoogleFonts.outfit(
                          fontSize: isSmall ? 12.5 : 13.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textWhite,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Back To Top
              GestureDetector(
                onTap: onBackToTop,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: AppColors.cyan,
                    size: 17,
                  ),
                ),
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

          // Copyright & Info
          Text(
            'Crafted with Flutter & Clean Architecture • © ${DateTime.now().year} ${CVData.name}',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isSmall ? 11 : 12,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
