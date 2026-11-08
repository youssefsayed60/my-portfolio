import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Clean, high-performance ambient background without continuous particle repaints.
/// Uses static, subtle ambient radial gradients that render once with zero CPU/GPU overhead.
class BackgroundCanvas extends StatelessWidget {
  final Widget child;

  const BackgroundCanvas({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Solid restrained dark base
        Positioned.fill(
          child: Container(
            color: AppColors.bgDark,
          ),
        ),

        // Subtle ambient radial glow 1 (Top Left)
        Positioned(
          top: -160,
          left: -140,
          child: IgnorePointer(
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.cyan.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        // Subtle ambient radial glow 2 (Center Right)
        Positioned(
          top: 700,
          right: -180,
          child: IgnorePointer(
            child: Container(
              width: 700,
              height: 700,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.blue.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        // Subtle ambient radial glow 3 (Bottom Center)
        Positioned(
          bottom: 100,
          left: -100,
          child: IgnorePointer(
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.violet.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        // Child Content
        child,
      ],
    );
  }
}
