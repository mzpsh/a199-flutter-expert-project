import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be able to create tvseries object from tvseriesdetail', () {
    final entity = testTVSeriesDetail;
    final tvSeriesEntity = entity.toTVSeries();

    // ignore: unnecessary_type_check
    expect(tvSeriesEntity is TVSeries, true);
  });

  test('props should return correct value', () {
    final entity = testTVSeriesDetail;
    final id = entity.props[0];

    expect(id, testTVSeriesDetail.id);
  });
}
