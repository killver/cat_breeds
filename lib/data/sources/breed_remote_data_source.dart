import 'package:pets_breeds/core/network/api_client.dart';
import 'package:pets_breeds/data/models/breed_model.dart';

class BreedRemoteDataSource {
  final ApiClient apiClient;

  BreedRemoteDataSource({required this.apiClient});

  Future<List<BreedModel>> fetchBreeds() async {
    final response = await apiClient.get('/breeds');
    return (response as List).map((json) => BreedModel.fromJson(json)).toList();
  }
}
