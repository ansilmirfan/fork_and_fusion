import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';

class Utils {
  static String extractFileName(String path) {
    return path.split('/').last;
  }

  static String capitalizeEachWord(String word) {
    if (word.isEmpty) {
      return word;
    }
    return word
        .split(' ')
        .map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase())
        .join(' ');
  }

  static String removeAndCapitalize(String word) {
    return word
        .split('_')
        .map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase())
        .join(' ');
  }

  static List<String> extractCategoryNames(List<CategoryEntity> data) {
    return data.map((e) => Utils.capitalizeEachWord(e.name)).toList();
  }

  static int extractPrice(ProductEntity product) {
    int price;
    if (product.price != 0) {
      price = product.price as int;
    } else {
      price = product.variants.values
          .map((e) => e is String ? int.parse(e) : e)
          .toList()
          .reduce((a, b) => a < b ? a : b);
    }

    return price;
  }

  static calculateRating(List<int> nums) {
    if (nums.isEmpty) {
      return 0;
    }
    return (nums.reduce((a, b) => a + b)) ~/ nums.length;
  }

  static int calculateOffer(ProductEntity product,
      [String selectedVariant = '']) {
    int price = 1;
    if (selectedVariant.isNotEmpty && product.variants.isNotEmpty) {
      price = product.variants[selectedVariant] ?? 0;
    } else {
      price = extractPrice(product);
    }

    return price - (price * product.offer ~/ 100);
  }

  static String formatTime(DateTime date) {
    var hour = date.hour;
    var minuite = date.minute;
    String period = hour >= 12 ? 'PM' : "AM";
    hour = hour > 12
        ? hour - 12
        : hour == 0
            ? 12
            : hour;
    String time =
        ' ${hour < 10 ? '0$hour' : hour}:${minuite < 10 ? '0$minuite' : minuite} $period';

    return time;
  }

  static String formatDate(DateTime date) {
    var day = date.day;
    var month = date.month;

    String formatedDate =
        '${day < 10 ? '0$day' : day}/${month < 10 ? '0$month' : month}/${date.year}';
    return formatedDate;
  }
}
