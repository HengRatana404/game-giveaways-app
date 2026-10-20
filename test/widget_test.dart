import 'package:flutter_test/flutter_test.dart';
import 'package:game_giveaways_app/models/model_give_aways.dart';

void main() {
  test('ModelGiveAways JSON round trip', () {
    final json = {
      'id': 1,
      'title': 'Game',
      'worth': '\$9.99',
      'thumbnail': 't',
      'image': 'i',
      'description': 'd',
      'instructions': 'in',
      'open_giveaway_url': 'u',
      'published_date': '2025-10-18 10:00:00',
      'type': 'Game',
      'platforms': 'PC',
      'end_date': 'N/A',
      'users': 5,
      'status': 'Active',
      'gamerpower_url': 'g',
      'open_giveaway': 'o',
    };
    expect(ModelGiveAways.fromJson(json).toJson(), json);
  });
}
