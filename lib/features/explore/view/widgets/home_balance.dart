import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class BalanceInfo extends StatefulWidget {
  const BalanceInfo({super.key, required this.balance});

  final double balance;

  @override
  State<BalanceInfo> createState() => _BalanceInfoState();
}

class _BalanceInfoState extends State<BalanceInfo> with IntlFormats {
  bool isVisible = true;

  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final leftSide = int.tryParse(
        widget.balance.toString().split('.').elementAtOrNull(0) ?? '0');
    final rightSide = double.tryParse(
        '.${widget.balance.toString().split('.').elementAtOrNull(1) ?? '0'}');

    final child = isVisible
        ? Text.rich(
            TextSpan(
              text: '₦',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.bold
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
              children: [
                TextSpan(
                  text: currencyFormat(symbol: '').format(leftSide),
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.semi
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextSpan(text: decimalOnlyFormat.format(rightSide)),
              ],
            ),
          )
        : Text(
            '****',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.semi
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              'My balance',
              style: Theme.of(context).textTheme.bodyMedium?.regular.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
            ),
            InkWell(
              onTap: _toggleVisibility,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.smallHorizontalGutter / 2),
                child: AnimatedSwitcher(
                  duration: Constants.shortAnimationDuration,
                  child: isVisible
                      ? Icon(Icons.remove_red_eye,
                          key: const Key('visible'),
                          size: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6))
                      : Icon(Icons.remove_red_eye_outlined,
                          key: const Key('hidden'),
                          size: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6)),
                ),
              ),
            ),
          ],
        ),
        Constants.smallVerticalGutter.verticalSpace,
        child,
      ],
    );
  }
}
