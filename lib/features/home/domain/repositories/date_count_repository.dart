abstract class DateCountRepository {
  Map<int, int> getCounts();
  Future<void> addOrIncrement(DateTime day);
}
