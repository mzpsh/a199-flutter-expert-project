import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be able to convert movie table to json', () {
    final json = testMovieTable.toJson();

    expect(json['id'], testMovieTable.id);
    expect(json['title'], testMovieTable.title);
    expect(json['posterPath'], testMovieTable.posterPath);
    expect(json['overview'], testMovieTable.overview);
  });
}
