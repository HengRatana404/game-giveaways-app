import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/model_give_aways.dart';
import '../services/giveaway_service.dart';

final _giveawayServiceProvider = Provider<GiveawayService>((ref) {
  return GiveawayService();
}); // Provider

class GiveawayProvider extends AsyncNotifier<List<ModelGiveAways>> {
  @override
  FutureOr<List<ModelGiveAways>> build() {
    final service = ref.watch(_giveawayServiceProvider);
    return service.fetchGiveaways();
  }

  Future<void> refreshGiveaways() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(_giveawayServiceProvider);
      return service.fetchGiveaways();
    });
  }
}

final giveawayNotifierProvider = AsyncNotifierProvider(GiveawayProvider.new);

final giveawayDetailProvider = FutureProvider.autoDispose
    .family<ModelGiveAways, int>((ref, id) {
      final service = ref.watch(_giveawayServiceProvider);
      return service.get(id);
    });
