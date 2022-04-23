import 'dart:convert';

import 'package:ditonton/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tvseries_list.dart';

void main() {
  test('should be able to return a TVSeriesResponse from json', () {
    final json = jsonDecode(tvseries_list_json);
    final response = TVSeriesResponse.fromJson(json);

    expect(response.tvSeriesList[0].id, 69);
  });
  test('should be able to return a json from TVSeriesResponse', () {
    final json = jsonDecode(tvseries_list_json);
    final response = TVSeriesResponse.fromJson(json);

    final jsonFromResponse = response.toJson();

    expect(jsonFromResponse['results']?.isNotEmpty, true);
  });
}
