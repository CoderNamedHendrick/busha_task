import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routing/router.dart';
import '../../../../shared/shared.dart';
import '../../application/notifiers.dart';
import '../../domain/dtos/dtos.dart';
import '../widgets/widgets.dart';
import 'detail.dart';

class TransactionsHomePage extends ConsumerStatefulWidget {
  static const route = '/transactions';

  const TransactionsHomePage({super.key, required this.shortName});

  final String shortName;

  @override
  ConsumerState<TransactionsHomePage> createState() =>
      _TransactionsHomePageState();
}

class _TransactionsHomePageState extends ConsumerState<TransactionsHomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(transactionsViewModelProvider.notifier)
          .initialise(widget.shortName);
      ref
          .read(transactionsViewModelProvider.notifier)
          .fetchRecentTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BushaOverlayIndicator(
      isLoading: ref.watch(
          transactionsViewModelProvider.select((vm) => vm.uiState.isLoading)),
      message: Text('Fetching your ${widget.shortName} transactions'),
      child: Scaffold(
        appBar: AppBar(
          leading: const BushaBackButton(),
          centerTitle: true,
          title: Text('${widget.shortName} transactions'),
          titleTextStyle:
              Theme.of(context).appBarTheme.titleTextStyle?.semi.inter,
        ),
        body: ref.watch(transactionsViewModelProvider).when(
              onLoading: () => const SizedBox.shrink(),
              onError: (error) => Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalGutter),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Failed to fetch ${widget.shortName} transactions',
                      ),
                      Constants.verticalGutter.verticalSpace,
                      FilledButton(
                        onPressed: ref
                            .read(transactionsViewModelProvider.notifier)
                            .fetchRecentTransactions,
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text('Tap to try again'),
                      ),
                    ],
                  ),
                ),
              ),
              onSuccess: (state) => _Transactions(
                transactions: state.transactions,
              ),
            ),
      ),
    );
  }
}

class _Transactions extends ConsumerWidget {
  const _Transactions({required this.transactions});

  final List<TransactionDto> transactions;

  @override
  Widget build(BuildContext context, ref) {
    if (transactions.isEmpty) {
      return Center(
        heightFactor: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalGutter),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No transactions found',
                style: Theme.of(context).textTheme.titleSmall?.medium,
              ),
              Constants.verticalGutter.verticalSpace,
              FilledButton(
                onPressed: ref
                    .read(transactionsViewModelProvider.notifier)
                    .fetchRecentTransactions,
                child: const Text('Fetch again?'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      key: const Key('transactions_list'),
      padding:
          const EdgeInsets.symmetric(horizontal: Constants.horizontalGutter),
      itemBuilder: (context, index) => TransactionTile(
        key: Key('transaction$index'),
        transaction: transactions[index],
        onTap: () {
          context.pushNamed(TransactionDetailPage.route,
              arguments: transactions[index]);
        },
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.verticalGutter),
        child: Container(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
          height: 1,
        ),
      ),
      itemCount: transactions.length,
    );
  }
}
