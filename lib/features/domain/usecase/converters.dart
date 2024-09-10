class Converters {
  static String dateToString(DateTime date) {
    String converted = '${date.day}/${date.month}/${date.year}';
    return converted;
  }
}
