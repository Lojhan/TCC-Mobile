import 'package:mobile/helpers/valid_datestring.dart';

DateTime formatDate(dynamic date) {
  if (date is DateTime) {
    return date;
  }
  bool valid = validDateString(date);
  if (valid) {
    return DateTime.parse(date);
  }
  return DateTime.now();
}
