import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import '../../../connect/connect.dart';
import '../../../earn/earn.dart';
import '../../../explore/explore.dart';
import '../../../portfolio/portfolio.dart';
import '../../../spend/spend.dart';
import '../widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  static const route = '/dashboard';

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
  int currentPage = 0;

  static final _pages = [
    const ExploreHomePage(),
    const PortfolioHomePage(),
    const EarnHomePage(),
    const SpendHomePage(),
    const ConnectHomePage(),
  ];

  void _onIndexChanged(int page) {
    setState(() {
      currentPage = page;
    });
    DefaultTabController.of(context).index = page;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentPage = DefaultTabController.of(context).index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BushaBottomNav(
        index: currentPage,
        onTap: _onIndexChanged,
        selectedColor: Theme.of(context).colorScheme.onSurface,
        selectedIconColor: Colors.black,
        unselectedIconColor: Theme.of(context).colorScheme.surfaceTint,
        unselectedColor: Theme.of(context).colorScheme.surfaceTint,
        selectedLabelStyle: TextStyle(
            fontSize: 12, color: Theme.of(context).colorScheme.onSurface),
        unselectedLabelStyle: TextStyle(
            fontSize: 12, color: Theme.of(context).colorScheme.surfaceTint),
        items: [
          BushaBottomNavItem(
            label: 'Explore',
            iconBuilder: (context, color, icon) => SvgIcon(
              SvgAssets.exploreFilled,
              color: color,
              height: Theme.of(context).iconTheme.size,
              width: Theme.of(context).iconTheme.size,
            ),
          ),
          BushaBottomNavItem(
            label: 'Portfolio',
            iconBuilder: (context, color, _) => SvgIcon(
              SvgAssets.walletOutlined2,
              color: color,
              height: Theme.of(context).iconTheme.size,
              width: Theme.of(context).iconTheme.size,
            ),
          ),
          BushaBottomNavItem(
            label: 'Earn',
            iconBuilder: (context, color, _) => SvgIcon(
              SvgAssets.percentOutline,
              color: color,
              height: Theme.of(context).iconTheme.size,
              width: Theme.of(context).iconTheme.size,
            ),
          ),
          BushaBottomNavItem(
            label: 'Spend',
            iconBuilder: (context, color, _) => SvgIcon(
              SvgAssets.spendOutlined,
              color: color,
              height: Theme.of(context).iconTheme.size,
              width: Theme.of(context).iconTheme.size,
            ),
          ),
          BushaBottomNavItem(
            label: 'Connect',
            iconBuilder: (context, color, _) => SvgIcon(
              SvgAssets.peerChain,
              color: color,
              height: Theme.of(context).iconTheme.size,
              width: Theme.of(context).iconTheme.size,
            ),
          ),
        ],
      ),
    );
  }
}
