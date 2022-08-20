import 'package:flutter/material.dart';
import 'package:mobile/errors/errors.dart';

abstract class StatePayload {
  bool get loading;
  bool? get failed;
  dynamic get state;
  dynamic get hasData;
}

Widget decideFromState<T extends StatePayload>({
  required T state,
  required BuildContext context,
  required Widget initial,
  required Widget loading,
  required Widget failure,
  required Widget success,
}) {
  if (state.loading) {
    return loading;
  } else if (state.failed is Failure) {
    return failure;
  } else if (state.hasData) {
    return success;
  } else {
    return initial;
  }
}
