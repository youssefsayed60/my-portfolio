import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BackgroundCanvas extends StatefulWidget {
  final Widget child;

  const BackgroundCanvas({super.key, required this.child});

  @override
  State<BackgroundCanvas> createState() => _BackgroundCanvasState();
}

class _BackgroundCanvasState extends State<BackgroundCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Generate initial particles
    for (int i = 0; i < 40; i++) {
      _particles.add(
        Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: _random.nextDouble() * 2.5 + 1.0,
          speed: _random.nextDouble() * 0.15 + 0.05,
          opacity: _random.nextDouble() * 0.45 + 0.15,
          color: i % 2 == 0 ? AppColors.cyan : AppColors.purple,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark Base
        Positioned.fill(
          child: Container(
            color: AppColors.bgDark,
          ),
        ),

        // Ambient Radial Glow 1 (Top Left / Indigo)
        Positioned(
          top: -120,
          left: -100,
          child: Container(
            width: 550,
            height: 550,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.cyan.withValues(alpha: 0.08),
                  AppColors.cyan.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        // Ambient Radial Glow 2 (Center Right / Slate)
        Positioned(
          top: 600,
          right: -150,
          child: Container(
            width: 650,
            height: 650,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.blue.withValues(alpha: 0.07),
                  AppColors.blue.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        // Ambient Radial Glow 3 (Bottom Center / Indigo)
        Positioned(
          bottom: 200,
          left: 100,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.violet.withValues(alpha: 0.06),
                  AppColors.violet.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        // Animated Floating Particles
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(
                  particles: _particles,
                  progress: _controller.value,
                ),
              );
            },
          ),
        ),

        // Child Content
        widget.child,
      ],
    );
  }
}

class Particle {
  double x;
  double y;
  double radius;
  double speed;
  double opacity;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.opacity,
    required this.color,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final currentY = ((p.y - (progress * p.speed)) % 1.0) * size.height;
      final currentX = p.x * size.width;

      final paint = Paint()
        ..color = p.color.withValues(alpha: p.opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);

      canvas.drawCircle(Offset(currentX, currentY), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}
