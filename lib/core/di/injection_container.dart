import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghost_counter/features/home/data/repositories/date_count_repository_impl.dart';
import 'package:ghost_counter/features/home/data/sources/data_count_local_data_source.dart';
import 'package:ghost_counter/features/home/domain/repositories/date_count_repository.dart';
import 'package:hive/hive.dart';

final hiveBoxProvider = Provider<Box<int>>((ref) {
  return Hive.box<int>('ghost_counts');
});

final localDataSourceProvider = Provider<DateCountLocalDataSource>((ref) {
  return DateCountLocalDataSourceImpl(ref.read(hiveBoxProvider));
});

final repoProvider = Provider<DateCountRepository>((ref) {
  return DateCountRepositoryImpl(ref.read(localDataSourceProvider));
});
