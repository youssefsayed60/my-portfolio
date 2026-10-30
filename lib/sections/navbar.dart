import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../widgets/responsive_builder.dart';

class Navbar extends StatefulWidget {
  final Function(int sectionIndex) onNavItemSelected;
  final VoidCallback onContactPressed;

  const Navbar({
    super.key,
    required this.onNavItemSelected,
    required this.onContactPressed,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isMobileMenuOpen = false;

  final List<String> _navItems = [
    'About',
    'Experience',
    'Skills',
    'Projects',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : 16,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F23).withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.cyan.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo with User's Photo and Name
                    InkWell(
                      onTap: () => widget.onNavItemSelected(0),
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.cyan.withValues(alpha: 0.45),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                CVData.profileImage,
                                fit: BoxFit.cover,
                                alignment: const Alignment(0.05, -0.05),
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: AppColors.bgCard,
                                  child: const Icon(
                                    Icons.person,
                                    size: 18,
                                    color: AppColors.cyan,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Port ',
                                  style: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                TextSpan(
                                  text: 'folio',
                                  style: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.cyan,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Desktop Nav Items
                    if (isDesktop)
                      Row(
                        children: [
                          for (int i = 0; i < _navItems.length; i++)
                            _NavItemButton(
                              label: _navItems[i],
                              index: i,
                              onTap: () => widget.onNavItemSelected(i),
                            ),
                          const SizedBox(width: 16),
                          _HireMeButton(onPressed: widget.onContactPressed),
                        ],
                      )
                    else
                      // Mobile Menu Button
                      IconButton(
                        icon: Icon(
                          _isMobileMenuOpen ? Icons.close : Icons.menu_rounded,
                          color: AppColors.cyan,
                          size: 26,
                        ),
                        onPressed: () {
                          setState(() {
                            _isMobileMenuOpen = !_isMobileMenuOpen;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Mobile Dropdown Menu
        if (!isDesktop && _isMobileMenuOpen)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F23).withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.cyan.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 24,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < _navItems.length; i++)
                  InkWell(
                    onTap: () {
                      setState(() => _isMobileMenuOpen = false);
                      widget.onNavItemSelected(i);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        _navItems[i],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textWhite,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                _HireMeButton(
                  onPressed: () {
                    setState(() => _isMobileMenuOpen = false);
                    widget.onContactPressed();
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _NavItemButton extends StatefulWidget {
  final String label;
  final int index;
  final VoidCallback onTap;

  const _NavItemButton({
    required this.label,
    required this.index,
    required this.onTap,
  });

  @override
  State<_NavItemButton> createState() => _NavItemButtonState();
}

class _NavItemButtonState extends State<_NavItemButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(10),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _isHovered ? AppColors.cyan : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HireMeButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _HireMeButton({required this.onPressed});

  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: _isHovered ? AppColors.primaryGradient : null,
            color: _isHovered ? null : AppColors.cyan.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.cyan,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bolt_rounded,
                size: 18,
                color: _isHovered ? const Color(0xFFF4F4F5) : AppColors.cyan,
              ),
              const SizedBox(width: 6),
              Text(
                'Get In Touch',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _isHovered ? const Color(0xFFF4F4F5) : AppColors.cyan,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
