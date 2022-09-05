import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/helpers/format_date.dart';

import '../dummies/strings.dart';

void main() {
  test('Should correcly map dates', () {
    DateTime date = DateTime.parse(StringDummy.date);
    expect(date, date);
    expect(formatDate(StringDummy.date), date);
    expect(formatDate(''), isA<DateTime>());
    expect(formatDate(null), isA<DateTime>());
  });
}
