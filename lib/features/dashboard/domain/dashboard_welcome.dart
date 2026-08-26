class DashboardWelcome {
  DashboardWelcome._();

  static String title({required bool isFirstAccess, String? firstName}) {
    if (isFirstAccess) {
      return 'Bem-vindo, futuro engenheiro!';
    }

    final normalizedName = firstName?.trim();
    final displayName = normalizedName == null || normalizedName.isEmpty
        ? 'Estudante'
        : normalizedName;

    return 'Bem-vindo de volta, $displayName!';
  }

  static String subtitle({required bool isFirstAccess}) {
    return isFirstAccess
        ? 'Sua jornada no C\u00e1lculo come\u00e7a agora.'
        : 'Continue sua jornada no C\u00e1lculo.';
  }
}
