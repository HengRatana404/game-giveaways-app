import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: GameScreen(),
          item: ItemConfig(
            icon: Icon(Icons.sports_esports),
            title: "Games",
            activeForegroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            inactiveForegroundColor: Theme.of(context).colorScheme.onSecondaryContainer.withValues(alpha: 0.85),
          ), // ItemConfig
        ), // PersistentTabConfig
        PersistentTabConfig(
          screen: SettingsScreen(),
          item: ItemConfig(
            icon: Icon(Icons.settings),
            title: "Settings",
            activeForegroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            inactiveForegroundColor: Theme.of(context).colorScheme.onSecondaryContainer.withValues(alpha: 0.85),
          ), // ItemConfig
        ), // PersistentTabConfig
      ],
      navBarBuilder: (navBarConfig) => Style9BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
        ), // NavBarDecoration
      ), // Style9BottomNavBar
    ); // PersistentTabView
  }
}
