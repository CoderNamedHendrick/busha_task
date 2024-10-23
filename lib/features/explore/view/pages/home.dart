import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import '../widgets/widgets.dart';

class ExploreHomePage extends StatefulWidget {
  const ExploreHomePage({super.key});

  @override
  State<ExploreHomePage> createState() => _ExploreHomePageState();
}

class _ExploreHomePageState extends State<ExploreHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const SvgIcon(SvgAssets.scan),
        ),
        title: const Text('Explore'),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const SvgIcon(SvgAssets.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const _BellWithAlert(),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Section(
            border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onInverseSurface),
            ),
            child: const BalanceInfo(balance: 5000),
          ),
          Section(
            border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onInverseSurface),
            ),
            child: const MyAssets(),
          ),
          Section(
            border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onInverseSurface),
            ),
            padding: EdgeInsets.zero,
            child: const TodayTopMovers(),
          ),
          const Section(child: TrendingNews()),
        ],
      ),
    );
  }
}

class _BellWithAlert extends StatelessWidget {
  const _BellWithAlert();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: Stack(
        children: [
          const Positioned.fill(child: SvgIcon(SvgAssets.bellOutlined)),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.error,
                border:
                    Border.all(color: Theme.of(context).colorScheme.surface),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
