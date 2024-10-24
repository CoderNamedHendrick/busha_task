import 'package:flutter/material.dart';
import '../../../../routing/routing.dart';
import '../../../../shared/shared.dart';
import '../pages/asset_detail.dart';
import 'mover_tile.dart';
import 'price_movement.dart';

class TodayTopMovers extends StatelessWidget {
  const TodayTopMovers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: Constants.verticalGutter,
              left: Constants.horizontalGutter,
              right: Constants.horizontalGutter,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Top Movers',
                  style: Theme.of(context).textTheme.bodyLarge?.semi.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.95)),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'See all',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.semi
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalGutter),
            child: Row(
              children: [
                MoverTile(
                  name: 'Ethereum',
                  icon: const SvgIcon(
                    SvgAssets.ethereumCoin,
                    fit: BoxFit.fill,
                  ),
                  priceMovement: const PriceMovement.down(percentage: 1.76),
                  onTap: () {
                    context.pushNamed(AssetDetailPage.route);
                  },
                ),
                Constants.smallHorizontalGutter.horizontalSpace,
                MoverTile(
                  name: 'Bitcoin',
                  icon: const SvgIcon(
                    SvgAssets.bitcoinCoin,
                    fit: BoxFit.fill,
                  ),
                  priceMovement: const PriceMovement.up(percentage: 1.76),
                  onTap: () {
                    context.pushNamed(AssetDetailPage.route);
                  },
                ),
                Constants.smallHorizontalGutter.horizontalSpace,
                MoverTile(
                  name: 'Solana',
                  icon: const SvgIcon(
                    SvgAssets.solanaCoin,
                    fit: BoxFit.fill,
                  ),
                  priceMovement: const PriceMovement.up(percentage: 1.76),
                  onTap: () {
                    context.pushNamed(AssetDetailPage.route);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
