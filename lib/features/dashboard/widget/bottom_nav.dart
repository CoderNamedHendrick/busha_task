import 'package:flutter/material.dart';

class BushaBottomNav extends StatefulWidget {
  const BushaBottomNav({
    super.key,
    required this.index,
    required this.onTap,
    required this.items,
    this.selectedColor,
    this.unselectedColor,
    this.labelStyle,
    this.decorationColor,
    this.borderColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.backgroundColor,
  });

  final ValueChanged<int> onTap;
  final int index;
  final List<BushaBottomNavItem> items;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? labelStyle;
  final Color? decorationColor;
  final Color? borderColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final Color? backgroundColor;

  @override
  State<BushaBottomNav> createState() => _BushaBottomNavState();
}

class _BushaBottomNavState extends State<BushaBottomNav> {
  @override
  Widget build(BuildContext context) {
    final additionalBottomPadding = MediaQuery.viewPaddingOf(context).bottom;

    return Theme(
      data: Theme.of(context).copyWith(
        bottomNavigationBarTheme: Theme.of(context)
            .bottomNavigationBarTheme
            .copyWith(
              backgroundColor: widget.backgroundColor,
              selectedIconTheme: IconThemeData(color: widget.selectedIconColor),
              unselectedIconTheme:
                  IconThemeData(color: widget.unselectedIconColor),
              selectedItemColor: widget.selectedColor,
              unselectedItemColor: widget.unselectedColor,
              selectedLabelStyle: widget.labelStyle,
            ),
      ),
      child: Container(),
    );
  }
}

class BushaBottomNavItem {
  final String label;
  final Widget icon;
  final Widget? inactiveIcon;

  const BushaBottomNavItem({
    required this.label,
    required this.icon,
    this.inactiveIcon,
  });
}
