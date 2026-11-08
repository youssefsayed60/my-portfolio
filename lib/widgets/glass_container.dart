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
    final activeColor = widget.glowColor ?? AppColors.cyan;
    final isHovering = _isHovered && widget.enableHover;

    Widget cardBody = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      transform: isHovering
          ? Matrix4.translationValues(0, -3, 0)
          : Matrix4.identity(),
      decoration: BoxDecoration(
        color: isHovering ? AppColors.bgCardHover : AppColors.bgCard,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: isHovering
              ? activeColor.withValues(alpha: 0.45)
              : AppColors.glassBorder,
          width: 1.0,
        ),
        boxShadow: isHovering
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: activeColor.withValues(alpha: 0.08),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      padding: widget.padding ?? const EdgeInsets.all(24),
      child: widget.child,
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
