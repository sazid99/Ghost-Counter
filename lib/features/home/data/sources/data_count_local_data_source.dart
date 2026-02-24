import 'package:hive/hive.dart';

abstract class DateCountLocalDataSource {
  Map<int, int> getAllCounts();
  Future<void> incrementDay(int dayKey);
}

class DateCountLocalDataSourceImpl implements DateCountLocalDataSource {
  final Box<int> box;
  DateCountLocalDataSourceImpl(this.box);

  @override
  Map<int, int> getAllCounts() {
    return box.toMap().map((k, v) => MapEntry(k as int, v as int));
  }

  @override
  Future<void> incrementDay(int dayKey) async {
    final current = box.get(dayKey, defaultValue: 0) ?? 0;
    await box.put(dayKey, current + 1);
  }
}
