import 'package:flutter_svg/flutter_svg.dart';

class SvgAssets {
  static const _baseUri = 'assets/svgs/';

  static const arrowLeft = '${_baseUri}arrow_left.svg';
  static const bellOutlined = '${_baseUri}bell_outlined.svg';
  static const bitcoinCoin = '${_baseUri}bitcoin_coin.svg';
  static const ethereumCoin = '${_baseUri}ethereum_coin.svg';
  static const exploreFilled = '${_baseUri}explore_filled.svg';
  static const peerChain = '${_baseUri}peer_chain.svg';
  static const percentOutline = '${_baseUri}percent_outline.svg';
  static const polygonCoin = '${_baseUri}polygon_coin.svg';
  static const scan = '${_baseUri}scan.svg';
  static const solanaCoin = '${_baseUri}solana_coin.svg';
  static const spendOutlined = '${_baseUri}spend_outlined.svg';
  static const walletOutlined2 = '${_baseUri}wallet_outlined2.svg';

  static Future<void> preloadSvgs() async {
    const assetPaths = [
      arrowLeft,
      bellOutlined,
      bitcoinCoin,
      ethereumCoin,
      exploreFilled,
      peerChain,
      percentOutline,
      polygonCoin,
      scan,
      solanaCoin,
      spendOutlined,
      walletOutlined2,
    ];
    final svgFutures = <Future>[];
    for (final path in assetPaths) {
      final loader = SvgAssetLoader(path);
      svgFutures.add(svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null)));
    }
    await Future.wait(svgFutures);
  }
}

class ImageAssets {
  static const _baseUri = 'assets/images/';

  static const newsImage = '${_baseUri}news_image.png';
  static const tezosCoin = '${_baseUri}tezos_coin.png';
}
