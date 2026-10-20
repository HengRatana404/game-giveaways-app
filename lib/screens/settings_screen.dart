import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../apps/my_app.dart';
import '../providers/color_notifier_provider.dart';
import '../providers/theme_notifier_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    _dark = ref.watch(themeNotifierProvider);
    int selectedIndex = ref.watch(colorNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ), // AppBar
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.dark_mode_outlined),
              title: Text("Night Mode"),
              trailing: Switch(
                value: _dark,
                onChanged: (value) {
                  ref.read(themeNotifierProvider.notifier).toggleDark();
                },
              ), // Switch
            ), // ListTile
          ), // Card
          Card(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: colorList.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 80,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ), // SliverGridDelegateWithMaxCrossAxisExtent
              itemBuilder: (context, index) {
                final color = colorList[index];
                return InkWell(
                  onTap: () {
                    ref.read(colorNotifierProvider.notifier).changeIndex(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: color,
                    child: selectedIndex == index
                        ? Container(color: Colors.white, width: 16, height: 16)
                        : SizedBox(),
                  ), // Container
                ); // InkWell
              },
            ), // GridView.builder
          ), // Card
        ],
      ), // ListView
    ); // Scaffold
  }
}
