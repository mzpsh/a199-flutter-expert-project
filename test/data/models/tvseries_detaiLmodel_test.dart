import 'dart:convert';

import 'package:ditonton/data/models/tvseries_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tvseries_detail.dart';

void main() {
  test('able to create a tvseries detail reponse from json', () {
    var json = jsonDecode(tvseries_detail_json);
    var model = TVSeriesDetailResponse.fromJson(json);

    expect(model.id, json['id']);
  });

  test('able to return json from tvseries detail response', () {
    var json = jsonDecode(tvseries_detail_json);
    var model = TVSeriesDetailResponse.fromJson(json);

    var jsonFromModel = model.toJson();

    expect(jsonFromModel['id'], json['id']);
  });
}
