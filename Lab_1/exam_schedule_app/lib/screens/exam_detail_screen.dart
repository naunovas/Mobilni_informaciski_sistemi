import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;
  const ExamDetailScreen({Key? key, required this.exam}) : super(key: key);

  String getTimeLeft() {
    final now = DateTime.now();
    final difference = exam.dateTime.difference(now);

    if (difference.isNegative) return "Испитот е завршен";

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    return "$days дена, $hours часа";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Color.fromARGB(255, 255, 225, 248),
      appBar: AppBar(title: Text(exam.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Име на предмет: ${exam.name}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Датум и време: ${exam.dateTime.day}/${exam.dateTime.month}/${exam.dateTime.year} ${exam.dateTime.hour}:${exam.dateTime.minute.toString().padLeft(2,'0')}"),
            const SizedBox(height: 8),
            Text("Простории: ${exam.rooms.join(', ')}"),
            const SizedBox(height: 16),
            Text("Време до испит: ${getTimeLeft()}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
