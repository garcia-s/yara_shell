import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final DateTime firstDayOfMonth =
        DateTime(currentDate.year, currentDate.month, 1);
    final DateTime lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0);
    final int totalDays = lastDayOfMonth.day;

    // Days of the week headers
    final List<String> daysOfWeek = DateFormat.E().dateSymbols.SHORTWEEKDAYS;

    return SizedBox(
      width: 400,
      height: 400,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysOfWeek.map((day) {
              return Expanded(
                child: Center(
                    child: Text(day,
                        style: TextStyle(fontWeight: FontWeight.bold))),
              );
            }).toList(),
          ),
          SizedBox(height: 8.0),
          GridView.builder(
            shrinkWrap: true,
            itemCount: totalDays + firstDayOfMonth.weekday - 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (context, index) {
              // Check if we need an empty box before the first day of the month
              if (index < firstDayOfMonth.weekday - 1) {
                return Container(); // Empty box
              }

              // Calculate the day number for each box
              final dayNumber = index - firstDayOfMonth.weekday + 2;
              final isToday = dayNumber == currentDate.day;

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: isToday
                      ? BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8.0),
                        )
                      : null,
                  child: Center(
                    child: Text(
                      '$dayNumber',
                      style: TextStyle(
                        color: isToday ? Colors.white : Colors.black87,
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
