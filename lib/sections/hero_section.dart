import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/typewriter_text.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContactMe;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContactMe,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isPhotoHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showImageLightbox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 420, maxHeight: 560),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.cyan.withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  CVData.profileImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: Colors.white, size: 24),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
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
        vertical: isDesktop ? 50 : 20,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: _buildHeroText(context)),
                const SizedBox(width: 50),
                Expanded(flex: 5, child: _buildProfilePhoto(context)),
              ],
            )
          : Column(
              children: [
                _buildProfilePhoto(context),
                const SizedBox(height: 28),
                _buildHeroText(context),
              ],
            ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);

    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Greeting
        Text(
          'Hello, World! I am',
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.firaCode(
            fontSize: isDesktop ? 16 : (isSmall ? 13 : 14),
            fontWeight: FontWeight.w500,
            color: AppColors.cyan,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),

        // Full Name
        Text(
          CVData.name,
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: isDesktop ? 52 : (isSmall ? 30 : 36),
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
            height: 1.15,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 10),

        // Typewriter Animated Title
        TypewriterText(
          texts: CVData.typewriterTitles,
          style: GoogleFonts.outfit(
            fontSize: isDesktop ? 24 : (isSmall ? 16 : 18),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),

        // Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            CVData.bio,
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isSmall ? 13 : 15,
              height: 1.65,
              color: AppColors.textBody,
            ),
          ),
        ),
        const SizedBox(height: 26),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 10,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            _HeroActionButton(
              label: 'Explore Projects',
              icon: Icons.rocket_launch_rounded,
              isPrimary: true,
              onTap: widget.onViewProjects,
            ),
            _HeroActionButton(
              label: 'Get In Touch',
              icon: Icons.mail_outline_rounded,
              isPrimary: false,
              onTap: widget.onContactMe,
            ),
          ],
        ),
        const SizedBox(height: 26),

        // Social Links Bar
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            _SocialPill(
              icon: Icons.work_rounded,
              label: 'LinkedIn',
              onTap: () => _launchUrl(CVData.linkedIn),
            ),
            _SocialPill(
              icon: Icons.email_outlined,
              label: 'Email',
              onTap: () => _launchUrl('mailto:${CVData.email}'),
            ),
            _SocialPill(
              icon: Icons.chat_bubble_rounded,
              label: 'WhatsApp',
              onTap: () => _launchUrl('https://wa.me/201094348682'),
            ),
            _SocialPill(
              icon: Icons.phone_outlined,
              label: CVData.phone,
              onTap: () => _launchUrl('tel:${CVData.phone}'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final screenW = MediaQuery.sizeOf(context).width;
    final cardWidth = isDesktop ? 330.0 : (screenW * 0.65).clamp(190.0, 260.0);
    final cardHeight = cardWidth * 1.25;

    return Center(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isPhotoHovered = true),
        onExit: (_) => setState(() => _isPhotoHovered = false),
        child: AnimatedScale(
          scale: _isPhotoHovered ? 1.015 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: GestureDetector(
            onTap: () => _showImageLightbox(context),
            child: Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: AppColors.bgCard,
                border: Border.all(
                  color: _isPhotoHovered
                      ? AppColors.cyan.withValues(alpha: 0.5)
                      : AppColors.glassBorder,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                  if (_isPhotoHovered)
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.1),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      CVData.profileImage,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.bgCard,
                        child: const Icon(
                          Icons.person,
                          size: 90,
                          color: AppColors.cyan,
                        ),
                      ),
                    ),

                    // Subtle bottom gradient for depth
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.35),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    // Click to Zoom Badge
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.glassBorder,
                          ),
                        ),
                        child: const Icon(
                          Icons.zoom_in_rounded,
                          size: 16,
                          color: AppColors.textWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _HeroActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_HeroActionButton> createState() => _HeroActionButtonState();
}

class _HeroActionButtonState extends State<_HeroActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmall = Responsive.isSmallMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 18 : 22,
            vertical: isSmall ? 11 : 13,
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppColors.primaryGradient : null,
            color: widget.isPrimary
                ? null
                : (_isHovered
                    ? AppColors.bgCardHover
                    : AppColors.bgCard),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : (_isHovered ? AppColors.cyan.withValues(alpha: 0.5) : AppColors.glassBorder),
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.isPrimary
                          ? AppColors.cyan.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: isSmall ? 15 : 16,
                color: widget.isPrimary
                    ? AppColors.textWhite
                    : (_isHovered ? AppColors.cyan : AppColors.textWhite),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.outfit(
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w700,
                  color: widget.isPrimary
                      ? AppColors.textWhite
                      : (_isHovered ? AppColors.cyan : AppColors.textWhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialPill extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialPill> createState() => _SocialPillState();
}

class _SocialPillState extends State<_SocialPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmall = Responsive.isSmallMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 10 : 12,
            vertical: isSmall ? 6 : 7,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.cyan.withValues(alpha: 0.12)
                : AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppColors.cyan.withValues(alpha: 0.45)
                  : AppColors.glassBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: isSmall ? 13 : 14,
                color: _isHovered ? AppColors.cyan : AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: isSmall ? 11 : 12,
                  fontWeight: FontWeight.w500,
                  color: _isHovered ? AppColors.textWhite : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
