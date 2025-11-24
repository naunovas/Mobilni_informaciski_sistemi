import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_summary.dart';
import '../widgets/meal_grid_item.dart';
import 'detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ApiService api = ApiService();
  List<MealSummary> meals = [];
  bool loading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  // ✅ Load meals by category
  void _load() async {
    setState(() => loading = true);

    try {
      final list = await api.fetchMealsByCategory(widget.category);
      setState(() {
        meals = list;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading meals')),
      );
    }
  }

  // ✅ Search meals
  Future<void> _search(String q) async {
    if (q.trim().isEmpty) {
      _load();
      return;
    }

    setState(() => loading = true);

    try {
      final results = await api.searchMeals(q);

      final filteredMeals = results.map((d) => MealSummary(
        id: d.id,
        name: d.name,
        thumb: d.thumb,
      )).toList();

      setState(() {
        meals = filteredMeals;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error while searching')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search meals…',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _search,
            ),
          ),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      final meal = meals[index];
                      return MealGridItem(
                        meal: meal,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailScreen(mealId: meal.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
