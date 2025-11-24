import 'package:flutter/material.dart';
import '../models/meal_summary.dart';
class MealGridItem extends StatelessWidget {
final MealSummary meal;
final VoidCallback onTap;
const MealGridItem({required this.meal, required this.onTap});
@override
Widget build(BuildContext context) {
return GestureDetector(
onTap: onTap,
child: Card(
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Expanded(child: Image.network(meal.thumb, fit: BoxFit.cover)),
Padding(
padding: const EdgeInsets.all(8.0),
child: Text(meal.name, style: TextStyle(fontSize: 14), maxLines:
2, overflow: TextOverflow.ellipsis),
),
],
),
),
);
}
}
