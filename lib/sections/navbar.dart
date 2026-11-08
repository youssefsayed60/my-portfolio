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
    final isSmall = Responsive.isSmallMobile(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : (isSmall ? 10 : 14),
            vertical: isSmall ? 8 : 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.bgDarkSurface.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.glassBorder,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 12 : 18,
              vertical: isSmall ? 8 : 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brand Logo with User's Photo and Name
                Expanded(
                  child: InkWell(
                    onTap: () => widget.onNavItemSelected(0),
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: isSmall ? 28 : 34,
                          height: isSmall ? 28 : 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.cyan.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Image.asset(
                              CVData.profileImage,
                              fit: BoxFit.cover,
                              alignment: const Alignment(0.05, -0.05),
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: AppColors.bgCard,
                                child: const Icon(
                                  Icons.person,
                                  size: 16,
                                  color: AppColors.cyan,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Youssef ',
                                  style: GoogleFonts.outfit(
                                    fontSize: isSmall ? 14 : 17,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sayed',
                                  style: GoogleFonts.outfit(
                                    fontSize: isSmall ? 14 : 17,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.cyan,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      const SizedBox(width: 14),
                      _HireMeButton(onPressed: widget.onContactPressed),
                    ],
                  )
                else
                  // Mobile Menu Button
                  IconButton(
                    icon: Icon(
                      _isMobileMenuOpen ? Icons.close : Icons.menu_rounded,
                      color: AppColors.textWhite,
                      size: 22,
                    ),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
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

        // Mobile Dropdown Menu
        if (!isDesktop && _isMobileMenuOpen)
          Container(
            margin: EdgeInsets.symmetric(horizontal: isSmall ? 10 : 14),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.bgDarkSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
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
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Text(
                        _navItems[i],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textWhite,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
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
        borderRadius: BorderRadius.circular(8),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _isHovered ? AppColors.cyan : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 2,
                width: _isHovered ? 16 : 0,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
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
    final isDesktop = Responsive.isDesktop(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 18 : 14,
            vertical: isDesktop ? 8 : 10,
          ),
          decoration: BoxDecoration(
            gradient: _isHovered ? AppColors.primaryGradient : null,
            color: _isHovered ? null : AppColors.cyan.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.cyan.withValues(alpha: _isHovered ? 0.0 : 0.4),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bolt_rounded,
                size: 16,
                color: _isHovered ? AppColors.textWhite : AppColors.cyan,
              ),
              const SizedBox(width: 6),
              Text(
                'Get In Touch',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _isHovered ? AppColors.textWhite : AppColors.cyan,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
