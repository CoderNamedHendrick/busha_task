import 'package:flutter/material.dart';

import '../shared.dart';

class BushaOverlayIndicator extends StatelessWidget {
  const BushaOverlayIndicator({
    super.key,
    required this.child,
    this.isLoading = false,
    this.message,
  });

  final Widget child;
  final bool isLoading;
  final Widget? message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        if (isLoading)
          Positioned.fill(
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    strokeWidth: 8,
                  ),
                  if (message != null) ...[
                    (Constants.largeVerticalGutter + Constants.verticalGutter)
                        .verticalSpace,
                    DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .regular
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      child: message!,
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
