import 'package:flutter/material.dart';
import '../models/meal_detail.dart';


class RandomMealScreen extends StatelessWidget {
final MealDetail meal;


const RandomMealScreen({super.key, required this.meal});


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Recipe of the Day")),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Image.network(meal.thumbnail),
const SizedBox(height: 16),
Text(
meal.name,
style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
),
const SizedBox(height: 8),
Text("Category: ${meal.category}"),
Text("Origin: ${meal.area}"),
const SizedBox(height: 16),
const Text(
"Instructions",
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
const SizedBox(height: 8),
Text(meal.instructions),
],
),
),
);
}
}