import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import '../../domain/dtos/dtos.dart';

class TransactionDetailPage extends StatelessWidget with IntlFormats {
  static const route = '/transactions/detail';

  const TransactionDetailPage({super.key, required this.transaction});

  final TransactionDto transaction;

  @override
  Widget build(BuildContext context) {
    final metadataEntries = transaction.metadata.entries.toList();
    return Scaffold(
      appBar: AppBar(
        leading: const BushaBackButton(),
        centerTitle: true,
        title: const Text('Transaction details'),
        titleTextStyle:
            Theme.of(context).appBarTheme.titleTextStyle?.semi.inter,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.horizontalGutter)
                .add(const EdgeInsets.only(top: Constants.largeVerticalGutter)),
        child: Column(
          children: [
            _Info(title: 'Hash', content: Text(transaction.hash)),
            const _Separator(),
            _Info(
              title: 'Time',
              content: Text(transactionDateFormat.format(transaction.time)),
            ),
            const _Separator(),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _Info(
                  title: metadataEntries[index].key,
                  content: Text(metadataEntries[index].value.toString())),
              separatorBuilder: (_, __) => const _Separator(),
              itemCount: metadataEntries.length,
            ),
            (Constants.largeVerticalGutter + Constants.verticalGutter)
                .verticalSpace,
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.verticalGutter),
                child: Row(
                  children: [
                    SvgIcon(
                      SvgAssets.externalLink,
                      height: Theme.of(context).iconTheme.size,
                      width: Theme.of(context).iconTheme.size,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    Constants.horizontalGutter.horizontalSpace,
                    Expanded(
                      child: Text(
                        'View on blockchain explorer',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.regular
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.95)),
                      ),
                    ),
                    Constants.horizontalGutter.horizontalSpace,
                    RotatedBox(
                      quarterTurns: 2,
                      child: SvgIcon(
                        SvgAssets.arrowLeft,
                        semanticLabel: 'forward icon',
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.32),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalGutter),
      child: Container(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
        height: 1,
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.regular.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          ),
        ),
        Constants.horizontalGutter.horizontalSpace,
        Expanded(
          flex: 4,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge!.regular.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.95)),
            textAlign: TextAlign.end,
            child: content,
          ),
        ),
      ],
    );
  }
}
