import 'dart:async';

import 'package:flutter/material.dart';

FutureOr<void> showNoCamerasToast(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("No cameras available"),
    duration: Duration(seconds: 1),
  ));
}
