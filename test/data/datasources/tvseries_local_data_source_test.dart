import 'package:ditonton/data/datasources/db/sembast_database_helper.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSembastDatabaseHelper extends Mock implements SembastDatabaseHelper {}

void main() async {
  final storeRef = StoreRef.main();
  final db = await newDatabaseFactoryMemory().openDatabase('test.db');
  final dataSource = TVSeriesLocalDataSourcImpl(
    db: db,
    storeRef: storeRef,
  );
  test('should be able to return a true if the write success', () async {
    final result = await dataSource.writeWatchlistTVSeries([testTVSeriesModel]);
    expect(result, true);
  });

  test('should be able to return saved List of TVSeriesModel', () async {
    await dataSource.writeWatchlistTVSeries([testTVSeriesModel]);

    final result = await dataSource.readWatchlistTVSeries();
    expect(result, [testTVSeriesModel]);
  });
}
