import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class AssetTile extends StatelessWidget {
  const AssetTile({
    super.key,
    required this.name,
    required this.shortName,
    required this.amount,
    required this.priceMovement,
    this.icon,
    this.onTap,
  });

  final String name;
  final String shortName;
  final Widget amount;
  final Widget priceMovement;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          if (icon != null) ...[
            SizedBox(
              height: 40,
              width: 40,
              child: icon!,
            ),
            Constants.horizontalGutter.horizontalSpace,
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.regular
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                (Constants.smallHorizontalGutter / 4).verticalSpace,
                Text(
                  shortName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.regular
                      .copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Constants.horizontalGutter.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              amount,
              (Constants.smallHorizontalGutter / 4).verticalSpace,
              priceMovement,
            ],
          )
        ],
      ),
    );
  }
}
