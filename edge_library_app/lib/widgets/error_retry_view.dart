import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorRetryView extends StatefulWidget {
  const ErrorRetryView({
    super.key,
    required this.onRetry,
    this.retryButtonLabel = 'Retry',
    required this.message,
  });

  final FutureOr<void> Function() onRetry;

  final String retryButtonLabel;
  final String message;

  @override
  State<ErrorRetryView> createState() => _ErrorRetryViewState();
}

class _ErrorRetryViewState extends State<ErrorRetryView>
    with SingleTickerProviderStateMixin {
  RetryMode _mode = RetryMode.none;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.message,
          textAlign: TextAlign.center,
        ),
        const Gap(12),
        TextButton.icon(
          onPressed: _mode == RetryMode.none
              ? () async {
                  _controller.repeat();

                  if (mounted && _mode == RetryMode.none) {
                    setState(() {
                      _mode = RetryMode.retry;
                    });

                    try {
                      await widget.onRetry();
                    } finally {
                      _dismiss();
                    }
                  }
                }
              : null,
          icon: RotationTransition(
            turns: _controller,
            child: const Icon(Icons.refresh),
          ),
          label: Text(widget.retryButtonLabel),
        ),
      ],
    );
  }

  Future<void> _dismiss() async {
    if (mounted && _mode == RetryMode.retry) {
      setState(() {
        _mode = RetryMode.done;
      });
    }

    await Future.delayed(
      const Duration(seconds: 2),
    );

    setState(() {
      _mode = RetryMode.none;
    });

    _controller.stop();
  }
}

enum RetryMode { none, retry, done }
