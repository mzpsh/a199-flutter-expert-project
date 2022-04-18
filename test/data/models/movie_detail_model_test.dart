import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be able to convert movie detail response model to json', () {
    final json = testMovieDetailResponse.toJson();

    expect(json['id'], testMovieDetailResponse.id);
    expect(json['title'], testMovieDetailResponse.title);
  });
}
