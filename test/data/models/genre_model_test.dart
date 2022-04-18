import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be able to convert genre model to json', () {
    final json = tGenreModel.toJson();

    expect(json['id'], tGenreModel.id);
    expect(json['name'], tGenreModel.name);
  });
}
