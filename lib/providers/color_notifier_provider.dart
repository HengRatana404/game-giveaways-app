import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ColorNotifier extends StateNotifier<int> {
  ColorNotifier() : super(0) {
    _load();
  }

  final _key = "ColorNotifier";
  final _storage = FlutterSecureStorage();

  void _load() async {
    String value = await _storage.read(key: _key) ?? "0";
    int index = int.tryParse(value) ?? 0;
    state = index;
  }

  void changeIndex(int value) {
    state = value;
    _storage.write(key: _key, value: state.toString());
  }
}

final colorNotifierProvider = StateNotifierProvider<ColorNotifier, int>((ref) {
  return ColorNotifier();
}); // StateNotifierProvider
