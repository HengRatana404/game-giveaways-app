import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'apps/my_app.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}
