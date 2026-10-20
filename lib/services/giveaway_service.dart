import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/model_give_aways.dart';

class GiveawayService {
  final _baseUrl = 'https://www.gamerpower.com/api';

  Future<List<ModelGiveAways>> fetchGiveaways() async {
    final url = "$_baseUrl/giveaways";

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return await compute(modelGiveAwaysFromJson, response.body);
      }
      throw Exception('Server Error: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load giveaways: $e');
    }
  }

  Future<ModelGiveAways> get(int id) async {
    final url = "$_baseUrl/giveaway?id=$id";

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return await compute(modelGiveAwayDetailFromJson, response.body);
      }
      throw Exception('Server Error: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load giveaway detail: $e');
    }
  }
}
