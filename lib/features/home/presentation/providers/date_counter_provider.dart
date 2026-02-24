import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghost_counter/core/di/injection_container.dart';
import 'package:ghost_counter/features/home/domain/repositories/date_count_repository.dart';

final dateCounterProvider =
    NotifierProvider<DateCounterNotifier, Map<int, int>>(
      DateCounterNotifier.new,
    );

class DateCounterNotifier extends Notifier<Map<int, int>> {
  late final DateCountRepository _repo;

  @override
  Map<int, int> build() {
    _repo = ref.read(repoProvider);
    return _repo.getCounts();
  }

  Future<void> addDay(DateTime day) async {
    await _repo.addOrIncrement(day);
    state = _repo.getCounts();
  }
}
