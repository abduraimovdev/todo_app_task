import 'package:flutter/material.dart';
import 'package:todo_app/features/domain/entity/todo.dart';

class CalendarMonthData {
  final int year;
  final int month;

  int get daysInMonth => DateUtils.getDaysInMonth(year, month);

  int get firstDayOfWeekIndex => 0;

  int get weeksCount => ((daysInMonth + firstDayOffset) / 7).ceil();

  const CalendarMonthData({
    required this.year,
    required this.month,
  });

  int get firstDayOffset {
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;
    final result =
        (weekdayFromMonday - ((firstDayOfWeekIndex - 1) % 7)) % 7 - 1;
    return result == -1 ? 6 : result;
  }

  List<List<CalendarDayData>> get weeks {
    final res = <List<CalendarDayData>>[];
    var firstDayMonth = DateTime(year, month, 1);
    var firstDayOfWeek = firstDayMonth.subtract(Duration(days: firstDayOffset));

    for (var w = 0; w < weeksCount; w++) {
      final week = List<CalendarDayData>.generate(
        7,
        (index) {
          final date = firstDayOfWeek.add(Duration(days: index));

          final isActiveMonth = date.year == year && date.month == month;

          return CalendarDayData(
            date: date,
            isActiveMonth: isActiveMonth,
            isActiveDate: date.isToday,
          );
        },
      );
      res.add(week);
      firstDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    }
    return res;
  }
}

extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);

  DateTime get dayStart => DateTime(year, month, day);

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }
}

class CalendarDayData {
  final DateTime date;
  final bool isActiveMonth;
  final bool isActiveDate;

  const CalendarDayData({
    required this.date,
    required this.isActiveMonth,
    required this.isActiveDate,
  });
}

class CustomDate extends StatelessWidget {
  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;
  final List<TodoModel> eventModel;
  final DateTime date;

  const CustomDate({
    Key? key,
    required this.isActiveMonth,
    required this.isSelected,
    required this.date,
    required this.onTap,
    required this.eventModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int number = date.day;
    final isToday = date.isToday;
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          style: isSelected
              ? IconButton.styleFrom(backgroundColor: Colors.blue.shade300)
              : isToday
                  ? IconButton.styleFrom(backgroundColor: Colors.pink.shade300)
                  : null,
          icon: Text(
            number.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: isActiveMonth ? Colors.black : Colors.transparent),
          ),
        ),
        if (isActiveMonth)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: eventModel
                .map(
                  (event) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          color: Colors.primaries[event.priorityColor],
                          shape: BoxShape.circle),
                    );
                  },
                )
                .take(3)
                .toList(),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}

extension WeekToString on int {
  String toWeek() {
    return switch (this) {
      1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday",
      7 => "Sunday",
      _ => "",
    };
  }
}
