import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BushaOverlayIndicator(
      child: Scaffold(),
    );
  }
}
