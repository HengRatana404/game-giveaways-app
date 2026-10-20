import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/color_notifier_provider.dart';
import '../providers/theme_notifier_provider.dart';
import '../screens/detail_screen.dart';
import '../screens/main_screen.dart';

List<Color> colorList = [
  Colors.yellow,
  Colors.lime,
  Colors.green,
  Colors.orange,
  Colors.deepOrange,
  Colors.pinkAccent,
  Colors.pink,
  Colors.red,
  Colors.deepPurple,
  Colors.cyanAccent,
  Colors.cyan,
  Colors.lightBlue,
  Colors.blue,
  Colors.indigo,
  Colors.grey,
];

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool dark = ref.watch(themeNotifierProvider);
    int index = ref.watch(colorNotifierProvider);
    Color seedColor = colorList[index];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: dark ? .dark : .light,
      theme: ThemeData(
        brightness: .light,
        colorScheme: .fromSeed(seedColor: seedColor, brightness: .light),
      ), // ThemeData
      darkTheme: ThemeData(
        brightness: .dark,
        colorScheme: .fromSeed(seedColor: seedColor, brightness: .dark),
      ), // ThemeData
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => MainScreen());
          case '/detail':
            return MaterialPageRoute(
              builder: (context) => DetailScreen(),
              settings: settings,
            ); // MaterialPageRoute
          default:
            return MaterialPageRoute(
              builder: (context) => Text("No Screen Found"),
            ); // MaterialPageRoute
        }
      },
    ); // MaterialApp
  }
}
