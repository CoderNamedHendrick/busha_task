import 'package:flutter/material.dart';
import '../../../../shared/shared.dart';
import 'widgets.dart';

class MyAssets extends StatelessWidget with IntlFormats {
  const MyAssets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Constants.verticalGutter),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My assets',
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
        AssetTile(
          name: 'Bitcoin',
          shortName: 'BTC',
          icon: const SvgIcon(SvgAssets.bitcoinCoin, fit: BoxFit.fill),
          amount: Text(currencyFormat().format(24500000)),
          priceMovement: const PriceMovement.up(percentage: 1.76),
          onTap: () {},
        ),
        Constants.verticalGutter.verticalSpace,
        AssetTile(
          name: 'Ethereum',
          shortName: 'ETH',
          icon: const SvgIcon(SvgAssets.ethereumCoin, fit: BoxFit.fill),
          amount: Text(currencyFormat().format(4500)),
          priceMovement: const PriceMovement.down(percentage: 6.76),
          onTap: () {},
        ),
        Constants.verticalGutter.verticalSpace,
        AssetTile(
          name: 'Tezos',
          shortName: 'XTZ',
          icon: const Image(
            fit: BoxFit.fill,
            image: AssetImage(ImageAssets.tezosCoin),
          ),
          amount: Text(currencyFormat().format(4500)),
          priceMovement: const PriceMovement.up(percentage: 9.06),
          onTap: () {},
        ),
      ],
    );
  }
}
