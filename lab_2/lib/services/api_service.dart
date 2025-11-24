import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal_summary.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String base = 'https://www.themealdb.com/api/json/v1/1';

  // Categories
  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$base/categories.php');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['categories'] ?? [];
      return list.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Meals by category
  Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    final url = Uri.parse('$base/filter.php?c=${Uri.encodeComponent(category)}');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return list.map((e) => MealSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  // Search meals
  Future<List<MealDetail>> searchMeals(String query) async {
    final url = Uri.parse('$base/search.php?s=${Uri.encodeComponent(query)}');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return list.map((e) => MealDetail.fromJson(e)).toList();
    } else {
      throw Exception('Search failed');
    }
  }

  // Single meal
  Future<MealDetail> lookupMeal(String id) async {
    final url = Uri.parse('$base/lookup.php?i=${Uri.encodeComponent(id)}');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return MealDetail.fromJson(list[0]);
    } else {
      throw Exception('Lookup failed');
    }
  }

  // Random meal
  Future<MealDetail> randomMeal() async {
    final url = Uri.parse('$base/random.php');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return MealDetail.fromJson(list[0]);
    } else {
      throw Exception('Random failed');
    }
  }
}
