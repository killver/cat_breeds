import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pets_breeds/core/error/exceptions.dart';
import 'package:pets_breeds/core/network/api_constants.dart';

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<dynamic> get(String path) async {
    final response = await client.get(Uri.parse('$BASE_URL$path'), headers: {
      'x-api-key': API_KEY,
    });
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      for (var i = 0; i < data.length; i++) {
        if (data[i]['reference_image_id'] != null) {
          data[i]['imageUrl'] =
              await fetchBreedImage(data[i]['reference_image_id']);
        }
      }
      return data;
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String?> fetchBreedImage(String referenceImageId) async {
    if (referenceImageId.isEmpty) {
      return null;
    }

    final response = await http.get(
      Uri.parse('$BASE_URL/images/$referenceImageId'),
      headers: {'x-api-key': API_KEY},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['url'];
    } else {
      throw Exception('Failed to load breed image');
    }
  }
}
