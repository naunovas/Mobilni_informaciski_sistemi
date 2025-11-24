import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'categories_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ApiService api = ApiService();

  void openRandomMeal(BuildContext context) async {
    final meal = await api.randomMeal();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(mealId: meal.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meal App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome 🍽️",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CategoriesScreen()),
                );
              },
              child: const Text("Browse Categories"),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => openRandomMeal(context),
              child: const Text("Random Meal 🎲"),
            ),
          ],
        ),
      ),
    );
  }
}
