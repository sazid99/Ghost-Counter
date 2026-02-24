import 'package:ghost_counter/features/home/data/sources/data_count_local_data_source.dart';
import 'package:ghost_counter/features/home/domain/repositories/date_count_repository.dart';

class DateCountRepositoryImpl implements DateCountRepository {
  final DateCountLocalDataSource local;
  DateCountRepositoryImpl(this.local);

  int _dayKey(DateTime d) => d.year * 10000 + d.month * 100 + d.day;

  @override
  Map<int, int> getCounts() => local.getAllCounts();

  @override
  Future<void> addOrIncrement(DateTime day) {
    return local.incrementDay(_dayKey(DateTime(day.year, day.month, day.day)));
  }
}
