import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../models/meal_detail.dart';

class DetailScreen extends StatefulWidget {
  final String mealId;
  const DetailScreen({required this.mealId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final api = ApiService();

  MealDetail? meal;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final m = await api.lookupMeal(widget.mealId);
    setState(() {
      meal = m;
      loading = false;
    });
  }

  void openYoutube() async {
    if (meal == null || meal!.youtube.isEmpty) return;
    final url = Uri.parse(meal!.youtube);
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(meal!.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal!.thumb),
            const SizedBox(height: 10),
            Text(meal!.instructions),
            const SizedBox(height: 10),
            if (meal!.youtube.isNotEmpty)
              ElevatedButton(
                onPressed: openYoutube,
                child: const Text("Open YouTube"),
              )
          ],
        ),
      ),
    );
  }
}
