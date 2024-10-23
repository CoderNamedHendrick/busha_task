import 'package:flutter/material.dart';
import '../../../../shared/shared.dart';
import 'widgets.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

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
                'Trending news',
                style: Theme.of(context).textTheme.bodyLarge?.semi.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.95)),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'View more',
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
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return NewsTile.expanded(
                headlineTitle:
                    'Ethereum Co-founder opposes El-salvador Bitcoin Adoption policy',
                publication: 'CoinDesk',
                publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
                imageUrl: ImageAssets.newsImage,
                onTap: () {},
              );
            }

            return NewsTile.collapsed(
              headlineTitle:
                  'Ethereum Co-founder opposes El-salvador Bitcoin Adoption policy',
              publication: 'CoinDesk',
              publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
              imageUrl: ImageAssets.newsImage,
              onTap: () {},
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Constants.smallVerticalGutter / 2),
            child: Container(color: const Color(0xffe3e5e6), height: 1),
          ),
          itemCount: 3,
        ),
      ],
    );
  }
}
