import 'package:flutter/material.dart';
import 'package:mobile/errors/errors.dart';

Future<void> showPredictionFailureDialog(
    BuildContext context, Failure failure) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Failure on prediction'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('''There was an error on prediction, 
                  the image was saved for retrying later.'''),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
