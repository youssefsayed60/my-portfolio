import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? glowColor;
  final bool enableHover;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final LinearGradient? borderGradient;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16.0,
    this.glowColor,
    this.enableHover = true,
    this.onTap,
    this.width,
    this.height,
    this.borderGradient,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final activeGlow = widget.glowColor ?? AppColors.cyan;
    final isHovering = _isHovered && widget.enableHover;

    Widget cardBody = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      transform: isHovering
          ? Matrix4.translationValues(0, -6, 0)
          : Matrix4.identity(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: isHovering
            ? [
                BoxShadow(
                  color: activeGlow.withValues(alpha: 0.25),
                  blurRadius: 28,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: activeGlow.withValues(alpha: 0.12),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: widget.padding ?? const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isHovering
                    ? [
                        const Color(0xFF2E2E33).withValues(alpha: 0.75),
                        const Color(0xFF1F1F23).withValues(alpha: 0.85),
                      ]
                    : [
                        const Color(0xFF27272A).withValues(alpha: 0.55),
                        const Color(0xFF18181B).withValues(alpha: 0.65),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: isHovering
                    ? activeGlow.withValues(alpha: 0.6)
                    : AppColors.glassBorder,
                width: isHovering ? 1.5 : 1.0,
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );

    if (widget.onTap != null || widget.enableHover) {
      return MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: cardBody,
        ),
      );
    }

    return cardBody;
  }
}
