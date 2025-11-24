import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import 'category_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories = [];
  List<Category> filtered = [];
  final TextEditingController controller = TextEditingController();
  final ApiService api = ApiService();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await api.fetchCategories();
      if (!mounted) return;

      setState(() {
        categories = data;
        filtered = data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  void search(String value) {
    setState(() {
      filtered = categories
          .where((c) => c.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  // ✅ Random Recipe of the Day
  Future<void> openRandomMeal() async {
    try {
      final meal = await api.randomMeal();
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(meal.name),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(meal.thumb),
                  const SizedBox(height: 10),
                  Text("Category: ${meal.category}"),
                  Text("Origin: ${meal.area}"),
                  const SizedBox(height: 10),
                  const Text(
                    "Instructions:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(meal.instructions),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              )
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load random recipe")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Categories"),
        actions: [
          Row(
            children: [
              const Text(
                "Recipe of the Day",
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.shuffle),
                tooltip: "Recipe of the Day",
                onPressed: openRandomMeal,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Search category...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: search,
            ),
          ),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? const Center(child: Text("No categories found"))
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final cat = filtered[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            child: ListTile(
                              leading: Image.network(
                                cat.thumbnail,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.image_not_supported),
                              ),
                              title: Text(cat.name),
                              subtitle: Text(
                                cat.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        CategoryScreen(category: cat.name),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }
}
