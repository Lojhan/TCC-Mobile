bool validDateString(String? dateString) {
  if (dateString == null) {
    return false;
  }

  if (dateString.isEmpty) {
    return false;
  }
  try {
    DateTime.parse(dateString);
    return true;
  } catch (e) {
    return false;
  }
}
