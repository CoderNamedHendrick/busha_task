import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.child,
    this.border,
    this.padding,
  });

  final Widget child;
  final BoxBorder? border;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: border),
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: Constants.horizontalGutter,
              vertical: Constants.verticalMargin,
            ),
        child: child,
      ),
    );
  }
}
