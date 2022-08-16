bool isBase64(String s) {
  RegExp regex =
      RegExp(r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$');
  return regex.hasMatch(s);
}
