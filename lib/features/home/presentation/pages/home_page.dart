import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghost_counter/features/home/presentation/providers/date_counter_provider.dart';
import 'package:ghost_counter/features/home/presentation/providers/now_ticker_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  int _dayKey(DateTime d) => d.year * 10000 + d.month * 100 + d.day;

  DateTime _fromKey(int key) {
    final y = key ~/ 10000;
    final m = (key % 10000) ~/ 100;
    final d = key % 100;
    return DateTime(y, m, d);
  }

  String _fmtDate(DateTime d) {
    return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  String _fmtDuration(Duration dur) {
    if (dur.isNegative) dur = dur.abs();
    final days = dur.inDays;
    final hours = dur.inHours % 24;
    final minutes = dur.inMinutes % 60;

    if (days > 0) return '${days}d ${hours}h ${minutes}m';
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final counts = ref.watch(dateCounterProvider);
    final now = ref.watch(nowTickerProvider).value ?? DateTime.now();
    final entries = counts.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    int countForDay(DateTime day) => counts[_dayKey(day)] ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Ghost Counter'), centerTitle: true),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2030, 12, 31),

            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              ref.read(dateCounterProvider.notifier).addDay(selectedDay);
            },

            eventLoader: (day) {
              final c = countForDay(day);
              if (c == 0) return const [];
              return List.filled(c, 'x');
            },

            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isEmpty) return null;
                return Positioned(
                  bottom: 4,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final key = entries[index].key;
                final count = entries[index].value;
                final date = _fromKey(key);
                final isLast = index == entries.length - 1;
                final Duration dur = isLast
                    ? now.difference(date)
                    : _fromKey(entries[index + 1].key).difference(date);

                return ListTile(
                  leading: Text('${index + 1}.'),
                  title: Text(_fmtDate(date)),
                  subtitle: Text('count: $count'),
                  trailing: Text(_fmtDuration(dur)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
