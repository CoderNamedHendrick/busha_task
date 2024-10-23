import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class MoverTile extends StatelessWidget {
  const MoverTile({
    super.key,
    required this.name,
    required this.icon,
    required this.priceMovement,
    this.onTap,
  });

  final String name;
  final Widget icon;
  final Widget priceMovement;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 127,
            maxWidth: 150,
            minWidth: 150,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Constants.horizontalGutter),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: icon,
                ),
                Constants.smallVerticalGutter.verticalSpace,
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.regular
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                Constants.smallVerticalGutter.verticalSpace,
                priceMovement,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
