import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import '../../domain/dtos/dtos.dart';

class TransactionTile extends StatelessWidget with IntlFormats {
  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
  });

  final TransactionDto transaction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.hash,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      Theme.of(context).textTheme.bodyLarge?.regular.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.95),
                          ),
                ),
                Constants.smallVerticalGutter.verticalSpace,
                Text(
                  transaction.time.year < 1900
                      ? 'N\\A'
                      : transactionDateFormat.format(transaction.time),
                  style:
                      Theme.of(context).textTheme.bodyMedium?.regular.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.56),
                          ),
                ),
              ],
            ),
          ),
          Constants.horizontalGutter.horizontalSpace,
          RotatedBox(
            quarterTurns: 2,
            child: SvgIcon(
              SvgAssets.arrowLeft,
              semanticLabel: 'forward icon',
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.32),
            ),
          ),
        ],
      ),
    );
  }
}
