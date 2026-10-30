import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../widgets/glass_container.dart';
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

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // 3D Tilt offsets
  double _tiltX = 0;
  double _tiltY = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

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
              constraints: const BoxConstraints(maxWidth: 500, maxHeight: 650),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.cyan, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withValues(alpha: 0.4),
                    blurRadius: 40,
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
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: isDesktop ? 60 : 30,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: _buildHeroText(context)),
                const SizedBox(width: 50),
                Expanded(flex: 5, child: _buildCreativePhoto(context)),
              ],
            )
          : Column(
              children: [
                _buildCreativePhoto(context),
                const SizedBox(height: 40),
                _buildHeroText(context),
              ],
            ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [

        Text(
          'Hello, World! I am',
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.firaCode(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.w500,
            color: AppColors.cyan,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),

        // Full Name with Shader
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFE0E7FF), AppColors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            CVData.name,
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: isDesktop ? 56 : 40,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.0,
              height: 1.1,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Typewriter Animated Title
        TypewriterText(
          texts: CVData.typewriterTitles,
          style: GoogleFonts.outfit(
            fontSize: isDesktop ? 26 : 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),

        // Bio from CV
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            CVData.bio,
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.7,
              color: AppColors.textBody,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 14,
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
        const SizedBox(height: 36),

        // Social Links Bar
        Wrap(
          spacing: 12,
          runSpacing: 12,
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

  Widget _buildCreativePhoto(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final cardSize = isDesktop ? 400.0 : 300.0;

    return MouseRegion(
      onHover: (event) {
        if (!isDesktop) return;
        final size = cardSize;
        final x = (event.localPosition.dx - size / 2) / (size / 2);
        final y = (event.localPosition.dy - size / 2) / (size / 2);
        setState(() {
          _tiltX = -y * 0.15;
          _tiltY = x * 0.15;
        });
      },
      onExit: (_) {
        setState(() {
          _tiltX = 0;
          _tiltY = 0;
        });
      },
      child: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_tiltX)
            ..rotateY(_tiltY),
          alignment: FractionalOffset.center,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Main Photo Container
              GestureDetector(
                onTap: () => _showImageLightbox(context),
                child: Container(
                  width: cardSize,
                  height: cardSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: AppColors.bgDarkSurface,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(34),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          CVData.profileImage,
                          fit: BoxFit.cover,
                          alignment: const Alignment(0.05, 0.05),
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.bgCard,
                            child: const Icon(
                              Icons.person,
                              size: 100,
                              color: AppColors.cyan,
                            ),
                          ),
                        ),

                        // Subtle bottom gradient for readability
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.4),
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.cyan.withValues(alpha: 0.5),
                              ),
                            ),
                            child: const Icon(
                              Icons.zoom_in_rounded,
                              size: 18,
                              color: AppColors.cyan,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),






            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingHeroBadge extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _FloatingHeroBadge({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      borderRadius: 18,
      glowColor: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          transform: _isHovered
              ? Matrix4.translationValues(0, -3, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppColors.primaryGradient : null,
            color: widget.isPrimary
                ? null
                : const Color(0xFF2E2E33).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : (_isHovered ? AppColors.cyan : AppColors.glassBorder),
              width: 1.5,
            ),
            boxShadow: widget.isPrimary && _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.45),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: widget.isPrimary
                    ? const Color(0xFFF4F4F5)
                    : (_isHovered ? AppColors.cyan : AppColors.textWhite),
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: widget.isPrimary
                      ? const Color(0xFFF4F4F5)
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.cyan.withValues(alpha: 0.15)
                : const Color(0xFF27272A).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppColors.cyan.withValues(alpha: 0.7)
                  : AppColors.glassBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 15,
                color: _isHovered ? AppColors.cyan : AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 13,
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

