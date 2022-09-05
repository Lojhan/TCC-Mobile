bool formatBool(dynamic boolean) {
  var res = boolean;
  if (res == null) {
    return false;
  }
  res ??= boolean;

  if (res is String) {
    res = res == 'true';
  }

  return res;
}
