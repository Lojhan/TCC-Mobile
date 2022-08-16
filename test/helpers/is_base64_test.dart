import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/helpers/is_base64.dart';

import '../dummies/strings.dart';

void main() {
  String base64string = StringDummy.base64String;
  String notBase64string = StringDummy.notBase64String;

  test('Should return true if the value is a valid base64 string', () {
    bool result = isBase64(base64string);
    expect(result, true);
  });

  test('Should return false if the value is not a valid base64 string', () {
    bool result = isBase64(notBase64string);
    expect(result, false);
  });
}
