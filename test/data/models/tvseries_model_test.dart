import 'dart:convert';

import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../dummy_data/tvseries_list.dart';

void main() {
  test('should be able to create a tvseries model', () {
    final model = testTVSeriesModel;

    expect(model.id, 69);
  });

  test('should be able to create a tvseries model from json', () {
    final json = jsonDecode(tvseries_list_json);
    final model = TVSeriesModel.fromJson(json['results'][0]);

    expect(model.id, 69);
  });

  test('should be a to create a model from tvseries model', () {
    final model = testTVSeriesModel;

    final json = model.toJson();

    expect(json['id'], model.id);
  });

  test('should be able to create a tvseries model from entity', () {
    final entity = testTVSeries;
    final model = TVSeriesModel.fromEntity(entity);
    expect(model.id, entity.id);
  });

  test('should be able to create a entity from tvseries model', () {
    final model = testTVSeriesModel;
    final entity = model.toEntity();
    expect(model.id, entity.id);
  });
}
