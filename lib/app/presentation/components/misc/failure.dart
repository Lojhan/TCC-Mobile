import 'package:flutter/material.dart';

class FailureComponent extends StatelessWidget {
  final Function? onRetry;
  const FailureComponent({
    Key? key,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Failed to load predictions'),
        ],
      ),
    );
  }
}
