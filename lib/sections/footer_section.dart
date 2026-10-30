import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../widgets/responsive_builder.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onBackToTop;

  const FooterSection({super.key, required this.onBackToTop});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF111113),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                    ),
                    child: const Icon(
                      Icons.flutter_dash,
                      color: Color(0xFFF4F4F5),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${CVData.name} • Flutter Engineer',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),

              // Back To Top
              GestureDetector(
                onTap: onBackToTop,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E2E33),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: AppColors.cyan,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Divider
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.05),
          ),
          const SizedBox(height: 24),

          // Bottom Bar
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            runSpacing: 12,
            children: [
              Text(
                '© 2026 ${CVData.name}. All rights reserved. Clean Architecture & Responsive UI.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _FooterIcon(
                    icon: Icons.work_rounded,
                    onTap: () => _launchUrl(CVData.linkedIn),
                  ),
                  const SizedBox(width: 12),
                  _FooterIcon(
                    icon: Icons.email_outlined,
                    onTap: () => _launchUrl('mailto:${CVData.email}'),
                  ),
                  const SizedBox(width: 12),
                  _FooterIcon(
                    icon: Icons.chat_bubble_rounded,
                    onTap: () => _launchUrl('https://wa.me/201094348682'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _FooterIcon({required this.icon, required this.onTap});

  @override
  State<_FooterIcon> createState() => _FooterIconState();
}

class _FooterIconState extends State<_FooterIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered
                ? AppColors.cyan.withValues(alpha: 0.2)
                : const Color(0xFF27272A),
            border: Border.all(
              color: _isHovered ? AppColors.cyan : AppColors.glassBorder,
            ),
          ),
          child: Icon(
            widget.icon,
            size: 15,
            color: _isHovered ? AppColors.cyan : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

