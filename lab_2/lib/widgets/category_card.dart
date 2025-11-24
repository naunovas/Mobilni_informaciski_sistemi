import 'package:flutter/material.dart';
import '../models/category.dart';
class CategoryCard extends StatelessWidget {
final Category category;
final VoidCallback onTap;
const CategoryCard({required this.category, required this.onTap});
@override
Widget build(BuildContext context) {
return InkWell(
onTap: onTap,
child: Card(
child: Row(
children: [
Container(
width: 100,
height: 80,
child: Image.network(category.thumb, fit: BoxFit.cover),
),
SizedBox(width: 8),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(category.name, style: TextStyle(fontSize: 16,
fontWeight: FontWeight.bold)),
SizedBox(height: 6),
Text(
category.description.length > 80 ?
category.description.substring(0, 80) + '...' : category.description,
maxLines: 3,
overflow: TextOverflow.ellipsis,
),
],
),
),
],
),
),
);
}
}