import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onTap;

  const ExamCard({Key? key, required this.exam, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPast = exam.dateTime.isBefore(DateTime.now());

    return Card(
      color: isPast ? const Color.fromARGB(255, 114, 0, 140) : const Color.fromARGB(255, 233, 187, 251),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(exam.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 5),
                Text('${exam.dateTime.day}/${exam.dateTime.month}/${exam.dateTime.year}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 5),
                Text('${exam.dateTime.hour}:${exam.dateTime.minute.toString().padLeft(2,'0')}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.room, size: 16),
                const SizedBox(width: 5),
                Text(exam.rooms.join(', ')),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
