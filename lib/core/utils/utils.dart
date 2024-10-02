import 'dart:math';

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

  static int extractPrice(ProductEntity data) {
    if (data.price != 0) {
      return data.price as int;
    }

    var price = data.variants.values
        .map((e) => e is String ? int.parse(e) : e)
        .toList()
        .reduce((a, b) => a < b ? a : b);
    return price as int;
  }

  static calculateRating(List<int> nums) {
    if (nums.isEmpty) {
      return 0;
    }
    return (nums.reduce((a, b) => a + b))~/nums.length;
  }
}
