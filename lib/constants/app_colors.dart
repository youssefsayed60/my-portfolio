import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds — restrained, comfortable dark slate
  static const Color bgDark = Color(0xFF0F1117);
  static const Color bgDarkSurface = Color(0xFF161922);
  static const Color bgCard = Color(0xFF1A1F2C);
  static const Color bgCardHover = Color(0xFF222838);

  // Primaries & Accents — calm, restrained slate-blue & indigo palette
  static const Color cyan = Color(0xFF6366F1); // Elegant Indigo
  static const Color blue = Color(0xFF818CF8); // Soft Slate-Blue
  static const Color babyBlue = Color(0xFF38BDF8); // Subtle Sky Blue
  static const Color purple = Color(0xFF6366F1); // Cohesive alias
  static const Color violet = Color(0xFF4F46E5); // Deep Indigo
  static const Color emerald = Color(0xFF10B981); // Calm Mint/Green
  static const Color amber = Color(0xFFF59E0B); // Warm Amber
  static const Color rose = Color(0xFFEF4444); // Subdued Red

  // Text Hierarchy — crisp, clean, eye-friendly contrast
  static const Color textWhite = Color(0xFFF8FAFC);
  static const Color textBody = Color(0xFFCBD5E1);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Borders & Accents — subtle, clean, no jarring neon
  static const Color glassBorder = Color(0x1F94A3B8);
  static const Color glassBorderHover = Color(0x4D6366F1);
  static const Color cyanGlow = Color(0x1F6366F1);
  static const Color purpleGlow = Color(0x1F6366F1);
  static const Color babyBlueGlow = Color(0x1F38BDF8);

  // Gradients — smooth, restrained tonal transitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [violet, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient babyBlueGradient = LinearGradient(
    colors: [babyBlue, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [violet, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonGradient = LinearGradient(
    colors: [cyan, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A1F2C), Color(0xFF161922)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
