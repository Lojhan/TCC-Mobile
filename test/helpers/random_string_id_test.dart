import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/helpers/random_string_id.dart';

void main() {
  test('Should correcly create a random string id', () {
    expect(
      randomStringId(),
      isA<String>().having((s) => s.length, 'lenght', 12),
    );
    expect(
      randomStringId(len: 10),
      isA<String>().having((s) => s.length, 'lenght', 10),
    );
  });
}
