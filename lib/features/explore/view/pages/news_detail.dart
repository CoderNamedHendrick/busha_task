import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class NewsDetailPage extends StatelessWidget {
  static const route = '/news-detail';

  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BushaBackButton(),
        title: const Text('News Detail'),
      ),
      body: const Center(
        child: Text('News Detail'),
      ),
    );
  }
}
