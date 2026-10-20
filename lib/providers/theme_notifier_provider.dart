import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _load();
  }

  final _key = "ThemeNotifier";
  final _storage = FlutterSecureStorage();

  void _load() async {
    String value = await _storage.read(key: _key) ?? "false";
    state = bool.tryParse(value) ?? false;
  }

  void toggleDark() {
    state = !state;
    _storage.write(key: _key, value: state.toString());
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
}); // StateNotifierProvider
