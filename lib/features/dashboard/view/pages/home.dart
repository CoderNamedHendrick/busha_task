import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const route = '/';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 5,
      child: _View(),
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dashboard Page'),
      ),

    );
  }
}
