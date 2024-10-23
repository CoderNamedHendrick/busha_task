import '../../shared.dart';
import 'package:flutter/material.dart';

class BushaBackButton extends StatelessWidget {
  const BushaBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (!Navigator.of(context).canPop()) return const SizedBox.shrink();

    return IconButton(
      onPressed: onTap ?? Navigator.of(context).maybePop,
      tooltip: 'Back',
      icon: const SvgIcon(SvgAssets.arrowLeft, semanticLabel: 'Back icon'),
    );
  }
}
