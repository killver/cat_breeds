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
      return json.decode(response.body);
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
