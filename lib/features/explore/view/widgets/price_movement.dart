import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class PriceMovement extends StatelessWidget with IntlFormats {
  const PriceMovement.up({
    super.key,
    required this.percentage,
  }) : positive = true;

  const PriceMovement.down({
    super.key,
    required this.percentage,
  }) : positive = false;

  final bool positive;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final color = positive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.rotate(
          angle: positive ? -pi / 4 : pi / 4,
          child: Icon(
            Icons.arrow_forward,
            color: color,
            size: 16,
          ),
        ),
        Text(
          '${percentageFormat.format(percentage)}%',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.medium
              .copyWith(color: color),
        ),
      ],
    );
  }
}
