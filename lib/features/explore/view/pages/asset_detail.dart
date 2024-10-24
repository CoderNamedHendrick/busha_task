import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class AssetDetailPage extends StatelessWidget {
  static const route = '/asset-detail';

  const AssetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BushaBackButton(),
        title: const Text('Asset Detail'),
      ),
      body: const Center(
        child: Text('Asset Detail'),
      ),
    );
  }
}
