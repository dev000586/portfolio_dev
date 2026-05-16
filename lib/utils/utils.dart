
class Utils {
  static String getExperience(DateTime startDate) {
    final now = DateTime.now();

    int years = now.year - startDate.year;
    int months = now.month - startDate.month;

    // Adjust if current month is before start month
    if (months < 0) {
      years--;
      months += 12;
    }

    // Convert months to .5 if >= 6
    final half = months >= 6 ? 0.5 : 0.0;

    final total = years + half;

    // Remove .0 if whole number
    if (half == 0) {
      return '$years+';
    } else {
      return '$total+';
    }
  }
}