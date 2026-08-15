import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================================================
  // BRAND — CÁLCULO TRIVIAL
  // =========================================================

  static const Color primary = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFFBFDBFE);

  static const Color secondary = Color(0xFF06B6D4);
  static const Color secondaryDark = Color(0xFF0891B2);
  static const Color secondaryLight = Color(0xFFCFFAFE);

  static const Color navy = Color(0xFF07111F);
  static const Color navyLight = Color(0xFF0D1B2A);

  // =========================================================
  // BACKGROUNDS / SURFACES
  // =========================================================

  static const Color background = Color(0xFFF7F9FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF1F5F9);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // =========================================================
  // TEXT
  // =========================================================

  static const Color textPrimary = Color(0xFF101828);
  static const Color textSecondary = Color(0xFF667085);
  static const Color textMuted = Color(0xFF98A2B3);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textDisabled = Color(0xFFB8C0CC);

  // =========================================================
  // BORDERS / INPUTS
  // =========================================================

  static const Color border = Color(0xFFE4E7EC);
  static const Color borderStrong = Color(0xFFD0D5DD);

  static const Color inputBorder = Color(0xFFD0D5DD);
  static const Color inputBackground = Color(0xFFFFFFFF);
  static const Color inputFocusedBorder = primary;
  static const Color inputErrorBorder = Color(0xFFDC2626);

  // =========================================================
  // SEMANTIC STATES
  // =========================================================

  // Success
  static const Color success = Color(0xFF16A34A);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color successDark = Color(0xFF15803D);

  // Error / Danger
  static const Color error = Color(0xFFDC2626);

  // Mantido para compatibilidade com componentes existentes.
  static const Color danger = error;

  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFB91C1C);

  // Warning
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);

  // Information
  static const Color info = Color(0xFF0284C7);
  static const Color infoLight = Color(0xFFE0F2FE);
  static const Color infoDark = Color(0xFF0369A1);

  // =========================================================
  // INTERACTION STATES
  // =========================================================

  static const Color selectedBackground = Color(0xFFEFF6FF);

  static const Color hover = Color(0xFFF8FAFC);
  static const Color pressed = Color(0xFFE2E8F0);

  static const Color disabled = Color(0xFFE5E7EB);
  static const Color disabledForeground = Color(0xFF9CA3AF);

  static const Color locked = Color(0xFF94A3B8);
  static const Color lockedBackground = Color(0xFFF1F5F9);

  // =========================================================
  // GAMIFICATION
  // =========================================================

  static const Color xp = Color(0xFF7C3AED);
  static const Color xpLight = Color(0xFFEDE9FE);

  static const Color gold = Color(0xFFF59E0B);
  static const Color goldLight = Color(0xFFFEF3C7);

  static const Color achievement = Color(0xFF8B5CF6);
  static const Color achievementLight = Color(0xFFF3E8FF);

  // =========================================================
  // PROGRESS
  // =========================================================

  static const Color progressTrack = Color(0xFFE2E8F0);
  static const Color progressValue = primary;

  static const Color progressComplete = success;
  static const Color progressLocked = locked;

  // =========================================================
  // NAVIGATION
  // =========================================================

  static const Color navigationBackground = Color(0xFFFFFFFF);
  static const Color navigationActive = primary;
  static const Color navigationInactive = Color(0xFF98A2B3);

  // =========================================================
  // LOADING / EMPTY / OFFLINE
  // =========================================================

  static const Color loading = secondary;

  static const Color emptyStateIcon = Color(0xFF94A3B8);
  static const Color emptyStateBackground = Color(0xFFF8FAFC);

  static const Color offline = Color(0xFF475467);
  static const Color offlineBackground = Color(0xFFF2F4F7);

  // =========================================================
  // OVERLAYS / SHADOWS
  // =========================================================

  static const Color overlay = Color(0x66000000);
  static const Color shadow = Color(0x1A000000);
}