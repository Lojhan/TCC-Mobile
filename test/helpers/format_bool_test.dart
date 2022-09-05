import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/helpers/format_bool.dart';

void main() {
  test('Should correcly map bools', () {
    expect(formatBool(true), true);
    expect(formatBool(false), false);
    expect(formatBool('true'), true);
    expect(formatBool('false'), false);
    expect(formatBool(''), false);
    expect(formatBool(null), false);
  });
}
