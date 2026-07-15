class AppProgress {
  static bool algebraFundamentalCompleted = false;

  static void completeAlgebraFundamental() {
    algebraFundamentalCompleted = true;
  }

  static void resetProgress() {
    algebraFundamentalCompleted = false;
  }
}