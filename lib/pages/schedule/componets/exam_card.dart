import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({super.key, required this.exam});

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (exam.courseName.isNotEmpty) ...[
              Text(
                exam.courseName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
            ],
            if (exam.examTime.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: colorTheme.primary),
                  const SizedBox(width: 4),
                  Text(exam.examTime),
                ],
              ),
              const SizedBox(height: 4),
            ],
            if (exam.examLocation.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: colorTheme.primary),
                  const SizedBox(width: 4),
                  Text(
                      "${exam.examLocation}${exam.campus.isNotEmpty ? ' (${exam.campus})' : ''}"),
                ],
              ),
              const SizedBox(height: 4),
            ],
            if (exam.examFormat.isNotEmpty || exam.seatNumber.isNotEmpty)
              Row(
                children: [
                  if (exam.examFormat.isNotEmpty) ...[
                    Icon(Icons.assignment, size: 16, color: colorTheme.primary),
                    const SizedBox(width: 4),
                    Text(" ${exam.examFormat}"),
                  ],
                  if (exam.examFormat.isNotEmpty && exam.seatNumber.isNotEmpty)
                    const SizedBox(width: 16),
                  if (exam.seatNumber.isNotEmpty) ...[
                    Icon(Icons.event_seat, size: 16, color: colorTheme.primary),
                    const SizedBox(width: 4),
                    Text("座位号: ${exam.seatNumber}"),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}
