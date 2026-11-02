import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color bgDark = Color(0xFF18181B);
  static const Color bgDarkSurface = Color(0xFF1F1F23);
  static const Color bgCard = Color(0xFF27272A);
  static const Color bgCardHover = Color(0xFF2E2E33);

  // Primaries & Accents — calm indigo palette
  static const Color cyan = Color(0xFF6366F1);   // indigo
  static const Color blue = Color(0xFF818CF8);   // soft indigo-blue
  static const Color babyBlue = Color(0xFF38BDF8); // baby blue
  static const Color purple = Color(0xFF38BDF8); // baby blue (alias)
  static const Color violet = Color(0xFF4F46E5); // deeper indigo
  static const Color emerald = Color(0xFF34D399);
  static const Color amber = Color(0xFFFBBF24);
  static const Color rose = Color(0xFFF87171);

  // Text
  static const Color textWhite = Color(0xFFF4F4F5);
  static const Color textBody = Color(0xFFD4D4D8);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textMuted = Color(0xFF71717A);

  // Borders & Glows — subtle, no neon
  static const Color glassBorder = Color(0x336366F1);
  static const Color glassBorderHover = Color(0x806366F1);
  static const Color cyanGlow = Color(0x336366F1);
  static const Color purpleGlow = Color(0x3338BDF8);
  static const Color babyBlueGlow = Color(0x3338BDF8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [cyan, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient babyBlueGradient = LinearGradient(
    colors: [babyBlue, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [purple, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonGradient = LinearGradient(
    colors: [cyan, blue, rose],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x2627272A), Color(0x1418181B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
