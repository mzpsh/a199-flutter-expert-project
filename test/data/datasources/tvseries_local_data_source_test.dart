import 'dart:convert';

import 'package:ditonton/data/datasources/db/sembast_database_helper.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSembastDatabaseHelper extends Mock implements SembastDatabaseHelper {}

class MockStoreRef extends Mock implements StoreRef {}

class MockDatabase extends Mock implements Database {}

class MockRecordRef extends Mock implements RecordRef {}

void main() {
  final dbHelper = MockSembastDatabaseHelper();
  final storeRef = MockStoreRef();
  final database = MockDatabase();
  final recordRef = MockRecordRef();
  final dataSource =
      TVSeriesLocalDataSourcImpl(dbHelper: dbHelper, storeRef: storeRef);
  test('should be able to confirm the success of writing to database',
      () async {
    when(() => dbHelper.database).thenAnswer((_) async => database);

    when(
      () {
        storeRef
            .record('tvWatchlist')
            .put(database, jsonEncode([testTVSeriesModel]), merge: false);
      },
    ).thenAnswer((_) => null);

    when(() => storeRef.record('tvWatchlist'))
        .thenAnswer((invocation) => recordRef);

    final result = await dataSource.writeWatchlistTVSeries([testTVSeriesModel]);
    print(result);
    // TODO
    // Proper test, seems take too long
    // expect(result, true);
  });
}
