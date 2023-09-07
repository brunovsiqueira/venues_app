import 'package:flutter/material.dart';
import 'package:venues_app/src/exceptions/base/base_exception.dart';

class ExceptionWidget extends StatelessWidget {
  final BaseException exception;
  final Function? refreshCallback;
  const ExceptionWidget({
    required this.exception,
    this.refreshCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            exception.message,
          ),
          GestureDetector(
            child: const Icon(Icons.refresh),
            onTap: () {
              refreshCallback?.call();
            },
          )
        ],
      ),
    );
  }
}
