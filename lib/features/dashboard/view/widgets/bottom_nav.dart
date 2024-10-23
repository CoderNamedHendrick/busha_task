// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef IconBuilder = Widget Function(BuildContext, Color? color, Widget? icon);

class BushaBottomNav extends StatefulWidget {
  const BushaBottomNav({
    super.key,
    required this.index,
    required this.onTap,
    required this.items,
    this.selectedColor,
    this.unselectedColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
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
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: widget.backgroundColor,
          selectedIconTheme: IconThemeData(color: widget.selectedIconColor),
          unselectedIconTheme: IconThemeData(color: widget.unselectedIconColor),
          selectedItemColor: widget.selectedColor,
          unselectedItemColor: widget.unselectedColor,
          selectedLabelStyle: widget.selectedLabelStyle,
          unselectedLabelStyle: widget.unselectedLabelStyle,
        ),
      ),
      child: Builder(
        builder: (context) {
          return Container(
            height: 71 + additionalBottomPadding,
            padding: EdgeInsets.only(bottom: additionalBottomPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              border: Border(
                top: BorderSide(color: widget.borderColor ?? const Color(0xffe3e5e6)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                widget.items.length,
                (index) => _BushaBottomNavTile(
                  icon: widget.items[index].icon,
                  inactiveIcon: widget.items[index].inactiveIcon,
                  iconBuilder: widget.items[index].iconBuilder,
                  label: widget.items[index].label,
                  selected: widget.index == index,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    widget.onTap.call(index);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BushaBottomNavItem {
  final String label;
  final Widget? icon;
  final IconBuilder? iconBuilder;
  final Widget? inactiveIcon;

  const BushaBottomNavItem({
    required this.label,
    this.icon,
    this.iconBuilder,
    this.inactiveIcon,
  }) : assert(icon != null || iconBuilder != null,
            'icon or iconBuilder must be provided');
}

class _BushaBottomNavTile extends StatelessWidget {
  const _BushaBottomNavTile({
    this.icon,
    required this.label,
    this.selected = false,
    this.iconBuilder,
    this.inactiveIcon,
    required this.onTap,
  });

  final String label;
  final Widget? icon;
  final bool selected;
  final IconBuilder? iconBuilder;
  final VoidCallback onTap;
  final Widget? inactiveIcon;

  @override
  Widget build(BuildContext context) {
    final bottomNavItemTheme = Theme.of(context).bottomNavigationBarTheme;

    final itemColor = selected
        ? bottomNavItemTheme.selectedItemColor
        : bottomNavItemTheme.unselectedItemColor;
    final iconColor = selected
        ? bottomNavItemTheme.selectedIconTheme?.color
        : bottomNavItemTheme.unselectedIconTheme?.color;
    final labelStyle = selected
        ? bottomNavItemTheme.selectedLabelStyle
        : bottomNavItemTheme.unselectedLabelStyle;
    return InkWell(
      onTap: onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: labelStyle!.copyWith(color: itemColor),
        child: IconTheme(
          data: IconThemeData(size: 24, color: iconColor),
          child: Builder(
            builder: (context) {
              final child = AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: selected
                    ? Column(
                        key: const Key('selected icon'),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 36,
                            width: 56,
                            alignment: Alignment.center,
                            child: icon,
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                    : Column(
                        key: const Key('unselected icon'),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 36,
                            width: 56,
                            alignment: Alignment.center,
                            child: inactiveIcon ?? icon,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
              );
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconBuilder != null)
                    Container(
                      key: const Key('icon builder'),
                      height: 36,
                      width: 56,
                      padding: const EdgeInsets.only(bottom: 8),
                      child: iconBuilder!(context, iconColor, child),
                    )
                  else
                    child,
                  Text(label),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
